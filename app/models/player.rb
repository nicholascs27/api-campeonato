class Player < ApplicationRecord

  belongs_to :championship
  
  has_many :matchs

  before_create :set_zero

  def set_zero
    self.punctuation = 0
    self.victories = 0
    self.defeats = 0
    self.ties = 0
    self.home_victories = 0
    self.away_victories = 0
    self.bonus = 0
    self.punishment = 0
  end

end
