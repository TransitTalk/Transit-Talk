class Stop < ApplicationRecord
  has_many :issues, :foreign_key => 'stop_onestop_id'
  has_and_belongs_to_many :lines, :foreign_key => 'stop_onestop_id', :association_foreign_key => 'line_onestop_id'
  belongs_to :twin_stop, class_name: "Stop", required: false
  has_and_belongs_to_many :users, :foreign_key => 'stop_onestop_id'

  self.primary_key = "onestop_id"

  acts_as_mappable :default_units => :miles,
                   :default_formula => :sphere,
                   :distance_field_name => :distance,
                   :lat_column_name => :lattitude,
                   :lng_column_name => :longitude


  def original
    twin_stop || self
  end
end
