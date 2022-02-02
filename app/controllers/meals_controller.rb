class MealsController < ApplicationController
  def index
    @meals = Meal.all
    render json: @meals
  end
  
  # GET /mods/1
  def show
    set_meal
    render json: { meal: @meal, ingredients: @meal.ingredients }
  end
  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_meal
      @meal = Meal.find(params[:id])
    end
end
