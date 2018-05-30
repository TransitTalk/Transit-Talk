# frozen_string_literal: true

class Issue < ApplicationRecord
  belongs_to :user
  belongs_to :stop, foreign_key: "stop_onestop_id"
  belongs_to :vehicle, required: false
  belongs_to :line, foreign_key: "line_onestop_id"
  validates :types, presence: true
end
