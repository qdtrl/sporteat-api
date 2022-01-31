class ExercicesController < ApplicationController
  before_action :authenticate_user!

  def index
    render json: getExercicesByEquipementWithPerformance()
  end

  def show
    render json: getExerciceByEquipementWithPerformance(params[:id])
  end

  private
  def params_exercice
    params.require(:exercice).permit()
  end

  def getExerciceByEquipementWithPerformance(userCategorieChoice)
    resultats = []
    equipements = current_user.equipements.sort
    equipements.each do |equipement|
      exercices = Exercice.where(equipement_id: equipement.id, categorie: userCategorieChoice)
      if (exercices.length != 0) 
        resultats << { :equipement => equipement, :exercices => exercices}
      end
    end
    resultat = resultats[rand(0..resultats.length-1)]
    equipement = resultat[:equipement]
    exercice = resultat[:exercices][rand(0..resultat[:exercices].length-1)]  
    performance = current_user.my_performances.where(exercice_id: exercice.id).last 
    if (performance)
      return { :equipement => equipement, :exercice => exercice, :performance => performance }
    end
    return { :equipement => equipement, :exercice => exercice, :performance => 0 }
  end

  def getExercicesByEquipementWithPerformance
    resultats = []
    equipements = current_user.equipements.sort
    my_performances = current_user.my_performances
    index = 0
    equipements.each do |equipement|
      resultats << { :equipement => equipement, :exercices => []}
      exercices = Exercice.where(equipement_id: equipement.id)
      exercices.each do |exercice|
        performance = my_performances.where(exercice_id: exercice.id).last
        if (performance)
          resultats[index][:exercices] << { :exercice => exercice, :performance => performance }
        else
          resultats[index][:exercices] << { :exercice => exercice, :performance => 0}
        end 
      end
      index+=1
    end
    resultats
  end
end
