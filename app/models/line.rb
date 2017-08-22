class Line < ApplicationRecord
  has_many :issues
  has_and_belongs_to_many :stops, :foreign_key => 'line_onestop_id', :association_foreign_key => 'stop_onestop_id'
end
