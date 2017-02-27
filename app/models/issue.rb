class Issue < ApplicationRecord
  belongs_to :user
  belongs_to :stop
  belongs_to :vehicle, required: false
  belongs_to :line
  validates :types, presence: true
end
