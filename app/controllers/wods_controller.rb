class WodsController < ApplicationController
  before_action :authenticate_user!

  def index
    render json: getExercicesByEquipementWithPerformance()
  end

  def create
    @wod = GenWods.new(current_user).perform
    # Wod.create(cal: GetWodCalories.new(current_user, @wod).perform)
    render json: { wod: @wod }
  end

  private

  def params_wod
    params.require(:wod).permit()
  end

  def getExercicesByEquipementWithPerformance
    resultat = []
    @equipements = current_user.equipements.sort
    @my_performances = current_user.my_performances
    index = 0
    @equipements.each do |equipement|
      resultat << { :equipement => equipement, :exercices => []}
      exercices = Exercice.where(equipement_id: equipement.id)
      exercices.each do |exercice|
        performance = @my_performances.where(exercice_id: exercice.id).last
        if (performance)
          resultat[index][:exercices] << { :exercice => exercice, :performance => performance }
        else
          resultat[index][:exercices] << { :exercice => exercice, :performance => 0}
        end 
      end
      index+=1
    end
    return resultat
  end
end
