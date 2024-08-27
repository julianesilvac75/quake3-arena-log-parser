class DeathMeansController < ApplicationController
  def index
    @death_means = DeathMean.all
    @kills = Kill.all
  end
end
