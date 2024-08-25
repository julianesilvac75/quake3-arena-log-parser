class MatchesController < ApplicationController
  def index
  end

  def show
    @matches = Match.all
  end
end
