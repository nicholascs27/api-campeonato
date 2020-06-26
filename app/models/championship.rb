class Championship < ApplicationRecord

  has_many :players, dependent: :destroy
  has_many :matchs, dependent: :destroy

end
