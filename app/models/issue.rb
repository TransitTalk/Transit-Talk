class Issue < ApplicationRecord
  belongs_to :user
  belongs_to :stop, require: false
  belongs_to :vehicle, require: false
end
