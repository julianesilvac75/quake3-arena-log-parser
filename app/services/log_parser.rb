class LogParser
  attr_reader :current_match

  def initialize(log_file_path)
    @log_file_path = log_file_path
    @current_match = 0
  end

  def parse
    logs = filter_logs

    logs.each do |line|
      if line.include?("InitGame:")
        create_match
      elsif line.include?("ClientUserinfoChanged")
        create_player(line)
      elsif line.include?("Kill:")
        "kill"
      end
    end

    logs
  end

  def create_match
      new_match = Match.create
      @current_match = new_match.id

      new_match
  end

  def create_player(line)
    name_match = line.match(/n\\([^\\]+)\\t/)
    # match_data = line.match(/ClientUserinfoChanged:\s(\d+)\sn([^\t\\]+)/)
    player_name = name_match[1]

    player_object = Player.find_by(name: player_name)

    if player_object == nil
      Player.create(name: player_name)
    else
      player_object
    end
  end

  def filter_logs
    @logs_categories = [ "InitGame:", "ClientUserinfoChanged:", "Kill:" ]
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
