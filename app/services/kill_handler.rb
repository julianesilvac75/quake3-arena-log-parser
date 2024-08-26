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
    get_death_mean

    puts "#{@killer ? @killer.name : "<world>" } matou #{@killed.name} com o modo #{@death_mean.name}"

    Kill.create(
      match_id: @current_match,
      killer: @killer,
      killed: @killed,
      death_mean: @death_mean
    )
  end

  def get_death_mean
    death_mean = DeathMean.find_by_name(@death_mean)
    if death_mean
      @death_mean = death_mean
    else
      @death_mean = DeathMean.create(name: @death_mean)
    end
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
