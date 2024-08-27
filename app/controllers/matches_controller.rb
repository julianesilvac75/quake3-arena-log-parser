class MatchesController < ApplicationController
  before_action :set_match, only: [ :show ]
  def index
    @matches = Match.all
  end

  def show
    @match = Match.find(params[:id])

    kills_by_player = KillsCalculator.new(@match)
    @kills_result = kills_by_player.calculate_kills

    @death_means = DeathMean.all
    @kills = @match.kills
  end

  def kills
    @kills = Match.find(params[:id]).kills
    @match_id = params[:id]
  end

  private

  def set_match
    @match = Match.find_by(id: params[:id])
    unless @match
      redirect_to not_found_path, alert: "Match não encontrado"
    end
  end
end
