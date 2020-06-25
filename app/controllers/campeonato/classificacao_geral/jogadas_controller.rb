class Campeonato::ClassificacaoGeral::JogadasController < ApplicationController

  http_basic_authenticate_with name: 'seleção2020', password: 'rubyonrails'

  
  def create

    # Create campeonato
    championship = Championship.create(name: "Campeonato #{Championship.all.count + 1}")

    params[:jogadas].each do |e|
    
      # Create Player
      player1 = Player.find_or_create_by(name: e[:jogada].split[0], championship: championship)
      player2 = Player.find_or_create_by(name: e[:jogada].split[2], championship: championship)

      # Create Match
      match = Match.find_or_create_by(home_player_id: player1.id, away_player_id: player2.id, championship: championship)

      # Create Result
      if match.results.size < 3
        result = Result.create(home_score: e[:resultado].split[0], away_score: e[:resultado].split[2], match_id: match.id)
      end

      # Rules
      if match.results.size == 3
        match.verificar_se_todas_as_jogada_foram_com_mesma_quantidade_de_pulos
        match.vencedor_da_partida
        match.quantidade_de_pulos_menor_que_tres
      end
    end

    @players = championship.players.all.sort_by { |player| [-player.victories, -player.away_victories, -player.bonus, player.punishment] } 

    render json: { classificacao_geral: @players, vencedor: @players.first.name }
  end

  private
    def authenticate
      authenticate_or_request_with_http_basic do |user_name, password| 
        user_name == USER_NAME && password == PASSWORD
      end
    end
end
