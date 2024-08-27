class KillsCalculator
  def initialize(match)
    @match = match
    @death_means = []
    @kills_by_player = {}
  end

  def calculate_kills
    players = @match.players

    players.each do |player|
      player_name = player.name
      player_kills = @match.kills.where(killer: player).size
      world_kills = @match.kills.where(killer: nil, killed: player).size

      @kills_by_player[player_name] = player_kills - world_kills
    end

    @kills_by_player
  end

  def list_death_means
    kills = @match.kills

    kills.each do |kill|
      @death_means << kill.death_means.name
    end

    @death_means
  end
end
