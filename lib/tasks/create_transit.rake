namespace :transit do

  def verify_file(path)
    unless path.present?
      puts "no file specified. Please specify a file with \"GTFS_FILE=\" before command"
      exit 1
    end
    unless File.exist?(path)
      puts "file not available: #{path}"
      exit 1
    end
  end

  task create_lines: :environment do
    path = ENV['GTFS_FILE']
    verify_file(path)
    source = GTFS::Source.build(path)
    lines = []
    source.routes.each do |r|
      lines << Line.new(
        name: r.id,
        route_long_name: r.long_name,
        system_type: r.type,
        color: r.color,
      )
    end
    $lines = lines
    puts source.routes.length.to_s + " Lines created"
  end

  task create_stops: :environment do
    path = ENV['GTFS_FILE']
    verify_file(path)
    source = GTFS::Source.build(path)
    stops = []
    source.stops.each do |s|
      stops << Stop.new(
        api_id: s.id,
        name: s.name,
        longitude: s.lon,
        lattitude: s.lat,
      )
    end
    $stops = stops
    puts source.stops.length.to_s + " Stops created"
  end

  task pair_stops: :environment do
    stops = $stops
    stops.group_by do |s|
      [s.longitude, s.lattitude]
    end
    .each do |latlong, stops|
      original, *twins = stops
      twins.each do |twin|
        twin.twin_stop_id = original.id
      end
    end

    $stops = stops

    # Pairing is done, so save
    Stop.import($stops)
    Line.import($lines)
  end

  def stop_times(trip_id)
    path = ENV['GTFS_FILE']
    verify_file(path)
    `unzip -o #{path} stop_times.txt -d tmp`
    stop_times_path = "#{Rails.root}/tmp/stop_times.txt"
    unless path.present?
      puts "File not extracted successfully. Exiting"
      exit 1
    end
    relevant_data = `grep ^#{trip_id}, #{stop_times_path}` # Urgh
    GTFS::StopTime.parse_stop_times(`head -1 #{stop_times_path}` + relevant_data)
  end

  task populate_lines: :environment do
    stops = Stop.all
    lines = Line.all
    pairs = []


    path = ENV['GTFS_FILE']
    verify_file(path)
    source = GTFS::Source.build(path)

    routes_done = Set.new
    source.trips.each do |trip|
      if routes_done.add?(trip.route_id)
        stops2 = stop_times(trip.id)
        .sort_by(&:arrival_time)
        .map do |stop_time|
          stops.find{|s| s.api_id == stop_time.stop_id }
        end
        .map(&:original)

        line = lines.find{|l| l.api_id == trip.route_id }
        stops2.each do |stop|
          pairs << [stop.id, line.id]
        end
      end
    end

    values = pairs.map{|p| "(" + p[0].to_s + "," + p[1].to_s + ")" }.join(",")
    ActiveRecord::Base.connection.execute("INSERT INTO lines_stops (stop_id, line_id) VALUES #{values}")
  end

  task set_up_transit: :environment do
    delete_transit_data

    puts "Reading Data..."
    ["transit:create_lines", "transit:create_stops", "transit:pair_stops", "transit:populate_lines"].each do |task|
      time = Time.now
      puts "Starting  " + task
      Rake::Task[task].invoke
      puts "Completed " + task + " - " + human_time_taken_since(time)
    end
    puts "Reading Data Complete!"
  end

  task set_up_transitland: :environment do
    delete_transit_data

    agency_onestop_id = ENV["TLAND_AGENCY_ONESTOP_ID"] # fetch the onestop_id of the agency

    # Setup arrays for storing data for bulk import
    tland_lines = []
    tland_stops = []
    tland_lines_stops = []

    # View API endpoints for transitland here: https://transit.land/documentation/datastore/api-endpoints.html
    root_url = 'https://transit.land/api/v1/'

    # Iterate through stops by 500
    per_page = 500
    response = HTTParty.get(root_url + 'stops?per_page='  + per_page.to_s + '&served_by=' + agency_onestop_id)
    i = 0

    # start a loop and break when there's no 'next' link
    loop do
      puts 'Stop request ' + i.to_s
      stop_response = JSON.parse response.body

      stop_response['stops'].each do |stop_obj|
        next if stop_obj['onestop_id'].include?('<')

        stop = Stop.new
        stop.onestop_id = stop_obj['onestop_id']
        stop.name = stop_obj['name']
        stop.longitude = stop_obj['geometry']['coordinates'][0] # takes [X, Y] format, aka [longitude, latitude]
        stop.lattitude = stop_obj['geometry']['coordinates'][1] # takes [X, Y] format, aka [longitude, latitude]
        stop.save
      end

      next_url = stop_response['meta']['next']

      break unless next_url

      response = HTTParty.get(next_url)
      i += 1
    end

    puts 'Done requesting stops'

    # Iterate through routes, ignoring geometry
    response = HTTParty.get(root_url + 'routes?operated_by=' + agency_onestop_id + '&include_geometry=false')

    i = 0

    # start a loop and break when there's no 'next' link
    loop do
      puts 'Line request ' + i.to_s
      route_response = JSON.parse(response.body)

      route_response['routes'].each do |route_obj|
        line = Line.new
        line.name = route_obj['name']
        line.route_long_name = route_obj['tags']['route_long_name']
        line.vehicle_type = route_obj['vehicle_type']
        line.wheelchair_accessible = route_obj['wheelchair_accessible']
        line.bikes_allowed = route_obj['bikes_allowed']
        line.color = route_obj['color']
        line.onestop_id = route_obj['onestop_id']

        # Create an array of pair arrays of form [stop_onestop_id, line_onestop_id], used for data importing
        lines_stops = route_obj['stops_served_by_route'].map{|hash| [hash['stop_onestop_id'], line.onestop_id]}
        tland_lines_stops = tland_lines_stops + lines_stops

        # Add lines to bul import set of lines
        tland_lines << line
      end

      next_url = route_response['meta']['next']

      break unless next_url

      response = HTTParty.get(next_url)
      i += 1
    end

    puts 'Done requesting lines'

    # Import all lines and stops
    Stop.import(tland_stops)
    Line.import(tland_lines)

    # Import relationships - each pair is [stop_onestop_id, line_onestop_id]
    values = tland_lines_stops.map{|pair| '("' + pair[0].to_s + '","' + pair[1].to_s + '")' }.join(',')
    ActiveRecord::Base.connection.execute("INSERT INTO lines_stops (stop_onestop_id, line_onestop_id) VALUES #{values}")
  end

  def delete_transit_data
    time = Time.now
    puts "Destroying Stops ..."
    Stop.destroy_all
    puts "Stops Destroyed - " + human_time_taken_since(time)

    time = Time.now
    puts "Destroying Lines ..."
    Line.destroy_all
    puts "Lines Destroyed - " + human_time_taken_since(time)
  end

  def human_time_taken_since(start_time)
    ms = ((TimeDifference.between(DateTime.now, start_time).in_seconds)*1000).round

    if(ms < 1000)
      return "took " + ms.to_s + "ms"
    else
      return "took " + TimeDifference.between(DateTime.now, start_time).humanize
    end
  end
end
