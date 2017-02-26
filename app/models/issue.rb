class Issue < ApplicationRecord
  belongs_to :user
  belongs_to :stop, required: false
  belongs_to :vehicle, required: false
end
