class Match < ApplicationRecord
  
  belongs_to :home_player, class_name: "Player"
  belongs_to :away_player, class_name: "Player"
  belongs_to :championship
  
  has_many :results

  before_create :set_zero

  def set_zero
    self.home_score = 0
    self.away_score = 0
  end
  
  def soma_resultado_jogador_casa
    self.results.sum(:home_score)
  end
  
  def soma_resultado_jogador_fora
    self.results.sum(:away_score)
  end
  
  def verificar_se_todas_as_jogada_foram_com_mesma_quantidade_de_pulos
    
    if self.results.pluck(:home_score).uniq.count == 1
      self.home_score += (soma_resultado_jogador_casa * 0.1).round
      self.save(validate: false)
    end

    if self.results.pluck(:away_score).uniq.count == 1
      self.away_score += (soma_resultado_jogador_fora * 0.1).round
      self.save(validate: false)
    end
  end
  
  def vencedor_da_partida
    if soma_resultado_jogador_casa > soma_resultado_jogador_fora
      
      self.home_player.punctuation = self.home_player.punctuation + 3
      self.home_player.victories = self.home_player.victories + 1
      self.home_player.home_victories = self.home_player.home_victories + 1
      
      self.home_player.save(validate: false)
    elsif soma_resultado_jogador_casa < soma_resultado_jogador_fora
      
      self.away_player.punctuation = self.away_player.punctuation + 3
      self.away_player.victories = self.away_player.victories + 1
      self.away_player.away_victories = self.away_player.away_victories + 1
      
      self.away_player.save(validate: false)
    else
      self.home_player.punctuation = self.home_player.punctuation + 1
      self.home_player.ties += 1

      self.away_player.punctuation = self.away_player.punctuation + 2
      self.away_player.ties += 1
      
      self.away_player.save(validate: false)
      self.home_player.save(validate: false)
    end
  end

  def quantidade_de_pulos_menor_que_tres
    if soma_resultado_jogador_casa < 3
      self.home_player.punctuation -= 1
      self.home_player.punishment += 1
      self.home_player.save(validate: false)
    end

    if soma_resultado_jogador_fora < 3
      self.away_player.punctuation -= 1
      self.away_player.punishment += 1
      self.away_player.save(validate: false)
    end
  end
end
