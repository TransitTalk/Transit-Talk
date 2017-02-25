namespace :transit do
  task create_lines: :environment do
    source = GTFS::Source.build("#{Rails.root}/tmp/google_transit.zip")
    source.routes.each do |r|
      Line.create(
        api_id: r.id,
        name: r.long_name,
        system_type: r.type,
      )

    end


  end
end
