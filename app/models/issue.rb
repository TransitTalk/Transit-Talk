class Issue < ApplicationRecord
  # belongs_to :user
  belongs_to :stop, foreign_key: "stop_onestop_id"
  belongs_to :vehicle, required: false
  belongs_to :line, foreign_key: "line_onestop_id"

  validates :issue_type, presence: true
  validates :location_type, presence: true
  validates :reported_at, presence: true
  validates :stop_onestop_id, presence: :true
end
