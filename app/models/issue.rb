# frozen_string_literal: true

# == Schema Information
#
# Table name: issues
#
#  id              :integer          not null, primary key
#  stop_onestop_id :string
#  vehicle_id      :integer
#  description     :text
#  user_id         :integer
#  line_onestop_id :string
#  types           :string
#  resolved        :boolean
#  created_at      :datetime
#  updated_at      :datetime
#


class Issue < ApplicationRecord
  belongs_to :user, required: false
  belongs_to :stop, foreign_key: "stop_onestop_id"
  belongs_to :vehicle, required: false
  belongs_to :line, foreign_key: "line_onestop_id"
  serialize :types, Array
  validates :types, presence: true
end
