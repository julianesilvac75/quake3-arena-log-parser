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

  def get_death_mean_description
    case @death_mean
    when "MOD_TRIGGER_HURT"
      "by some environment danger."
    when "MOD_ROCKET_SPLASH"
      "with a rocket explosion."
    when "MOD_FALLING"
      "by falling from a height enough to kill."
    when "MOD_ROCKET"
      "with a rocket."
    when "MOD_RAILGUN"
      "with a railgun."
    when "MOD_MACHINEGUN"
      "with a machinegun."
    when "MOD_SHOTGUN"
      "with a shotgun."
    when "MOD_TELEFRAG"
      "by telegraffing them."
    when "MOD_BFG_SPLASH"
      "with a BFG splash damage."
    when "MOD_BFG"
      "with a BFG."
    when "MOD_CRUSH"
      "by being crushed by a moving door or platform."
    end
  end

  def get_death_mean
    death_mean = DeathMean.find_by_name(@death_mean)
    if death_mean
      @death_mean = death_mean
    else
      death_description = get_death_mean_description
      @death_mean = DeathMean.create(name: @death_mean, description: death_description)
    end
  end

  def get_killed_player
    @killed = Player.find_by_name(@killed)
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
