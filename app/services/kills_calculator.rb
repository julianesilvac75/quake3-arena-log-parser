class KillsCalculator
  def initialize(match)
    @match = match
    @kills_by_player = {}
  end

  def calculate_kills
    players = @match.players

    players.each do |player|
      player_name = player.name
      player_kills = match.kills.where(player: player).size
      world_kills = match.kills.where(player: nil, killed: player).size

      @kills_by_player[player_name] = player_kills - world_kills
    end

    @kills_by_player
  end
end
