class Result < ApplicationRecord

  belongs_to :match

  before_save :result_home_score_bigger_then_ten
  before_save :result_away_score_bigger_then_ten

  def result_home_score_bigger_then_ten
    if self.home_score > 10
      self.home_score += 2
      self.match.home_player.bonus += 1
      self.match.home_player.save(validate: false)
    end
  end

  def result_away_score_bigger_then_ten
    if self.away_score > 10
      self.match.away_player.bonus += 1
      self.match.away_player.save(validate: false)
      self.away_score += 2
    end
  end
  
end
