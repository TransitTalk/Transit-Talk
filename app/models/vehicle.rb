# frozen_string_literal: true

# == Schema Information
#
# Table name: vehicles
#
#  id      :integer          not null, primary key
#  api_id  :string
#  line_id :integer
#


class Vehicle < ApplicationRecord
  belongs_to :line
end
