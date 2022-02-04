class WodsController < ApplicationController
  before_action :authenticate_user!

  def index
    render json: 
    [
      { 
        wod: 
        {
          id: 1, 
          name:  "Mon Wod de Ouf du bas du corps",
          calories: 231
        }, 
        exercices: [
        {
          equipement: { id: 1, name: "Poids de corps", weight: 0 },
          exercice: { id: 1, name: "Squat", categorie: "lower-body"},
          performance: { id: 1, repetitions: 20, rounds: 4, weight: 0 },
        },
        {
          equipement: { id: 1, name: "Poids de corps", weight: 0 },
          exercice: { id: 1, name: "Squat pistols", categorie: "lower-body"},
          performance: { id: 1, repetitions: 20, rounds: 4, weight: 0 },
        },
        {
          equipement: { id: 1, name: "Poids de corps", weight: 0 },
          exercice: { id: 1, name: "Deadlift", categorie: "lower-body"},
          performance: { id: 1, repetitions: 20, rounds: 4, weight: 0 },
        },
        {
          equipement: { id: 1, name: "Poids de corps", weight: 0 },
          exercice: { id: 1, name: "Fentes", categorie: "lower-body"},
          performance: { id: 1, repetitions: 20, rounds: 4, weight: 0 },
        }] 
      },
      {
        wod: 
        { 
          id: 2,
          name:  "Mon Wod de Ouf du haut du corps",
          calories: 231
        }, 
        exercices: [
        {
          equipement: { id: 1, name: "Poids de corps", weight: 0 },
          exercice: { id: 1, name: "Pompes", categorie: "upper-body"},
          performance: { id: 1, repetitions: 20, rounds: 4, weight: 0 }
        },
        {
          equipement: { id: 1, name: "Poids de corps", weight: 0 },
          exercice: { id: 1, name: "Pull-up", categorie: "upper-body"},
          performance: { id: 1, repetitions: 20, rounds: 4, weight: 0 }
        },
        {
          equipement: { id: 1, name: "Poids de corps", weight: 0 },
          exercice: { id: 1, name: "Muscle-up", categorie: "upper-body"},
          performance: { id: 1, repetitions: 20, rounds: 4, weight: 0 }
        },
        {
          equipement: { id: 1, name: "Poids de corps", weight: 0 },
          exercice: { id: 1, name: "Dips", categorie: "upper-body"},
          performance: { id: 1, repetitions: 20, rounds: 4, weight: 0 }
        }] 
      },
    ]
    # Decommanter c'est ce que tu veux mais tu dois changer la DB
    # render json: Wod.where(user_id: current_user).includes(:exercices, :performances)
  end

  def create
    @wod = GenWods.new(current_user).perform
    render json: { wod: @wod }
  end

  def destroy
    puts "Boom"
  end

  private

  def params_wod
    params.require(:wod).permit()
  end
end
