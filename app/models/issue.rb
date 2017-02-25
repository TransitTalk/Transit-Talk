class Issue < ApplicationRecord
  belongs_to :user
  belongs_to :stop
  belongs_to :vehicle
end
