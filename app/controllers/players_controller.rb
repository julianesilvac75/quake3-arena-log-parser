class PlayersController < ApplicationController
  def index
    @players = Players.all
  end
end
