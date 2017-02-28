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
        api_id: r.id,
        name: r.long_name,
        system_type: r.type,
        color: r.color,
      )
    end
    Line.import(lines)
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
    Stop.import(stops)
    puts source.stops.length.to_s + " Stops created"
  end

  task pair_stops: :environment do
    Stop.all.group_by do |s|
      [s.longitude, s.lattitude]
    end
    .each do |latlong, stops|
      original, *twins = stops
      twins.each do |twin|
        twin.twin_stop_id = original.id
        twin.save
      end
    end
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
    path = ENV['GTFS_FILE']
    verify_file(path)
    source = GTFS::Source.build(path)

    routes_done = Set.new
    source.trips.each do |trip|
      if routes_done.add?(trip.route_id)
        stops = stop_times(trip.id)
        .sort_by(&:arrival_time)
        .map do |stop_time|
          Stop.find_by(
            api_id: stop_time.stop_id
          )
        end
        .map(&:original)

        line = Line.find_by(
          api_id: trip.route_id
        )
        line.stops = stops

        line.save
      end
    end
  end

  task set_up_transit: :environment do

    time = Time.now
    puts "Destroying Stops ..."
    Stop.delete_all
    puts "Stops Destroyed - " + human_time_taken_since(time)

    time = Time.now
    puts "Destroying Lines ..."
    Line.delete_all
    puts "Lines Destroyed - " + human_time_taken_since(time)

    puts "Reading Data..."
    ["transit:create_lines", "transit:create_stops", "transit:pair_stops", "transit:populate_lines"].each do |task|
      time = Time.now
      puts "Starting  " + task
      Rake::Task[task].invoke
      puts "Completed " + task + " - " + human_time_taken_since(time)
    end
    puts "Reading Data Complete!"
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
