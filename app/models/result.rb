class Result < ApplicationRecord

  belongs_to :match

  validates :match_id, presence: true

  before_save :resultado_jogada_casa_maior_que_dez
  before_save :resultado_jogada_fora_maior_que_dez

  def resultado_jogada_casa_maior_que_dez
    if self.home_score > 10
      self.home_score += 2
      self.match.home_player.bonus += 1
      self.match.home_player.save(validate: false)
    end
  end

  def resultado_jogada_fora_maior_que_dez
    if self.away_score > 10
      self.match.away_player.bonus += 1
      self.match.away_player.save(validate: false)
      self.away_score += 2
    end
  end
  
end
