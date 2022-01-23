class GenWods
  def initialize(current_user)
    @user = current_user
    @my_equipements = MyEquipement.where(user_id: current_user)
    @wod = []
  end

  def pick_exercices(exercices)
    choseen_exercices = []
    number_of_exercices = rand(2..4)
    number_of_exercices.times do
      choseen_exercices << exercices[rand(0..exercices.length-1)]
    end
    return choseen_exercices
  end

  def generate_warm_up
    exercices = []
    @my_equipements.each do |eq|
      exercices += Exercice.where(equipement_id: eq.equipement_id).warm_ups
    end
    @wod << { :name => "Echauffement", :time => { :min => rand(3..5), :sec => rand(0..60) } ,:rep_set => rand(1..3), :set => { :rep => rand(10..20), :exercices => pick_exercices(exercices) }}
  end

  def generate_skills
    exercices = []
    @my_equipements.each do |eq|
      exercices += Exercice.where(equipement_id: eq.equipement_id).skills
    end
    @wod << { :name => "Compétences", :time => { :min => rand(3..5), :sec => rand(0..60) } ,:rep_set => 1, :set => { :rep => 10, :exercices => pick_exercices(exercices) } }
  end

  def generate_workout
    exercices = []
    @my_equipements.each do |eq|
      exercices += Exercice.where(equipement_id: eq.equipement_id).workouts
    end
    @wod << { :name => "Wod", :time => { :min => rand(5..20), :sec => rand(0..60) } ,:rep_set => rand(1..3), :set => { :rep => rand(10..20), :exercices => pick_exercices(exercices) } }
  end
  
  def generate_set_building(exercices) 
    exercices = pick_exercices(exercices)
    set = []
    exercices.each do |exercice|
      performance = MyPerformance.where(user_id: @user, exercice_id: exercice.id).last
      if (performance)
        set << { :rep => performance.repetitions + 1, :exercice => exercice}
      else
        set << { :rep => 6, :exercice => exercice}
      end
    end
    return set
  end

  def generate_building
    exercices = []
    @my_equipements.each do |eq|
      exercices += Exercice.where(equipement_id: eq.equipement_id).buildings
    end
    @wod << { :name => "Renforcement",:time => { :min => 1, :sec => 0 } ,:rep_set => 3, :set => generate_set_building(exercices) }
  end

  def perform
    case rand(1..2)
    when 1
      generate_warm_up
      generate_skills
      generate_workout
    when 2
      generate_warm_up
      generate_building
    end
    return @wod
  end
end
 