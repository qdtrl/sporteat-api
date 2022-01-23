class MyPerformancesController < ApplicationController
  before_action :authenticate_user!

  def index
    @performances = MyPerformance.where(user_id: current_user.id)
    @exercices = [];
    @performances.each do |perfomance|
      if @exercices.include?(perfomance.exercice)
        next
      else
        @exercices.append(perfomance.exercice)
      end
    end
    render json: { performances: @performances, exercices: @exercices.sort }, status: 200
  end

  def create
    HandleSavePerformances.new(current_user, params[:_json]).perform
  end
end
