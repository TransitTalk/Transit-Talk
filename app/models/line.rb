# frozen_string_literal: true

class Line < ApplicationRecord
  has_many :issues, foreign_key: "line_onestop_id"
  has_and_belongs_to_many :stops,
    foreign_key: "line_onestop_id",
    association_foreign_key: "stop_onestop_id"

  self.primary_key = "onestop_id"

  # Returns the longest available name
  def long_name
    route_long_name ? route_long_name : name
  end

  # Returns the short name if it is different from the long name
  # Ex: short_name({route_long_name: "Ashland", name: "9"}) => "9"
  # Ex: short_name({route_long_name: "Red Line", name: "Red Line"}) => nil
  def short_name
    route_long_name != name ? name : nil
  end

  # GTFS reference says that a "route_type" of 3 indicates a bus line
  # https://developers.google.com/transit/gtfs/reference/#routestxt
  def bus?
    if system_type.nil?     # Prefer system_type if present
      vehicle_type == "bus"
    else
      system_type == 3
    end
  end
end
