class LogParser
  attr_reader :current_match

  def initialize(log_file_path)
    @log_file_path = log_file_path
    @current_match = 0
    @logs_categories = [ "InitGame:", "ClientUserinfoChanged:", "Kill:" ]
  end

  def parse
    logs = filter_logs

    logs.each do |line|
      if line.include?(@logs_categories[0])
        create_match
        puts "iniciou jogo: #{@current_match}"
      elsif line.include?(@logs_categories[1])
        handle_player(line)
      elsif line.include?(@logs_categories[2])
        puts "Passou pelo include de #{@logs_categories[2]}"
      end
    end

    logs
  end

  def create_match
      new_match = Match.create
      @current_match = new_match.id

      new_match
  end

  def handle_player(line)
    id_match = line.match(/ClientUserinfoChanged: (\d+)/)
    player_assigned_id = id_match[1] if id_match

    name_match = line.match(/n\\([^\\]+)\\t/)
    player_name = name_match[1] if name_match

    if player_assigned_id && player_name
      matches_player = handle_matches_player(player_name, player_assigned_id)
      matches_player.player
    else
      puts "Não conseguiu parsear: #{line}"
    end
  end

  def handle_matches_player(player_name, assigned_id)
    matches_player = find_matches_player(assigned_id)
    player_by_name = Player.find_by_name(player_name)

    if matches_player
      player = Player.find(matches_player.player_id)
      puts "Antes de mudar: #{player.name}"
      if player.update_name(player_name)
        puts "Atualizado! Depois de mudar: #{player.name}"
      else
        puts "Não atualizado porque nome já está em uso. Player: #{player.name}"
      end
    else
      if player_by_name == nil
        player_by_name = Player.create(name: player_name)
        puts "criou um novo player: #{player_by_name.name}"
      end

      matches_player = MatchesPlayer.create(match_id: @current_match, player: player_by_name, assigned_id: assigned_id, name_used: player_name)
      puts "Player já existente entrou no jogo: #{matches_player.player.name}"
    end

    matches_player
  end

  def find_matches_player(assigned_id)
    matches_player = MatchesPlayer.find_by(match_id: @current_match, assigned_id: assigned_id)

    if matches_player == nil
      nil
    else
      matches_player
    end
  end

  def filter_logs
    logs = []

    File.foreach(@log_file_path) do |line|
      @logs_categories.each do |category|
        if line.include?(category)
          logs << line
        end
      end
    end

    logs
  end
end
