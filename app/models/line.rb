# frozen_string_literal: true

# == Schema Information
#
# Table name: lines
#
#  id                    :integer          not null
#  route_long_name       :string
#  name                  :string
#  system_type           :integer
#  color                 :string
#  onestop_id            :string           primary key
#  vehicle_type          :string
#  wheelchair_accessible :string
#  bikes_allowed         :string
#


class Line < ApplicationRecord
  has_many :issues, foreign_key: "line_onestop_id"
  has_and_belongs_to_many :stops,
    foreign_key: "line_onestop_id",
    association_foreign_key: "stop_onestop_id"

  self.primary_key = "onestop_id"

  # GTFS route types
  TRAM_SYSTEM_TYPE = 0
  METRO_SYSTEM_TYPE = 1
  BUS_SYSTEM_TYPE = 3

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
      system_type == BUS_SYSTEM_TYPE
    end
  end

  def has_color?
    !color.nil? && !color.empty?
  end

  # GTFS reference says that a "route_type" of 0 or 1 indicates a train line
  # https://developers.google.com/transit/gtfs/reference/#routestxt
  def train?
    if system_type.nil?
      vehicle_type == "tram" || vehicle_type == "metro"
    else
      system_type == TRAM_SYSTEM_TYPE || system_type == METRO_SYSTEM_TYPE
    end
  end

  def line_type
    if train?
      "train"
    elsif bus?
      "bus"
    else
      nil
    end
  end

  # Query for bus/train lines.
  # line_type can be "train" or "bus".
  def self.of_line_type(line_type)
    if line_type == "train"
      Line.where(system_type: [TRAM_SYSTEM_TYPE, METRO_SYSTEM_TYPE])
        .or(Line.where(vehicle_type: ["tram", "metro"]))
        .order(:name)
    elsif line_type == "bus"
      Line.where(system_type: BUS_SYSTEM_TYPE)
        .or(Line.where(system_type: nil, vehicle_type: "bus"))
        .order(:name)
    else
      Line.order(:name)
    end
  end
end
