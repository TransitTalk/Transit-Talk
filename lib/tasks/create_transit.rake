namespace :transit do
  task create_lines: :environment do
    path = "#{Rails.root}/tmp/google_transit.zip"
    unless File.exist?(path)
      puts "file not available: #{path}"
      exit 1
    end
    source = GTFS::Source.build(path)
    source.routes.each do |r|
      Line.create!(
        api_id: r.id,
        name: r.long_name,
        system_type: r.type,
        color: r.color,
      )
    end
  end

  task create_stops: :environment do
    path = "#{Rails.root}/tmp/google_transit.zip"
    unless File.exist?(path)
      puts "file not available: #{path}"
      exit 1
    end
    source = GTFS::Source.build(path)
    source.stops.each do |s|
      Stop.create!(
        api_id: s.id,
        name: s.name,
        longitude: s.lon,
        lattitude: s.lat,
      )
    end
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
    path = "#{Rails.root}/tmp/stop_times.txt"
    relevant_data = `grep ^#{trip_id}, #{path}` # Urgh
    GTFS::StopTime.parse_stop_times(`head -1 #{path}` + relevant_data)
  end

  task populate_lines: :environment do
    path = "#{Rails.root}/tmp/google_transit.zip"
    unless File.exist?(path)
      puts "file not available: #{path}"
      exit 1
    end
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
    Stop.destroy_all
    Line.destroy_all
    ["transit:create_lines", "transit:create_stops", "transit:populate_lines"].each do |task|
      Rake::Task[task].invoke
    end
  end
end
