class Championship < ApplicationRecord
  has_many :players
  has_many :matchs
end
