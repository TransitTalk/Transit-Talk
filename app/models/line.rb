class Line < ApplicationRecord
  has_many :issues
  has_and_belongs_to_many :stops
end
