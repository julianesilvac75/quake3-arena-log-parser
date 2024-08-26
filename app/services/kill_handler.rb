class KillHandler
  def initialize(line, current_match)
    @line = line
    @current_match = current_match
    @killer = nil
    @killed = nil
    @death_mean = nil
  end

  def handle
    get_kill_info
    get_killer_player
    get_killed_player
  end

  def get_killer_player
    if @killer
      @killer = Player.find_by_name(@killer)
    end
  end

  def get_killer_player
    if @killer
      @killer = Player.find_by_name(@killer)
    end
  end

  def get_kill_info
    match_data = @line.match(/Kill: \d+ \d+ \d+: (.+?) killed (.+?) by (.+)/)

    @killer = match_data[1] == "<world>" ? nil : match_data[1]
    @killed = match_data[2]
    @death_mean = match_data[3]
  end
end
