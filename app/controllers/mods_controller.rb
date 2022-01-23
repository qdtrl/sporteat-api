class ModsController < ApplicationController
  before_action :authenticate_user!

    def index
      @mods = GenMods.new(current_user).perform
      render json: @mods
    end
  
    # GET /mods/1
    def show
      set_mod
      render json: @mod
    end
  
    
    private
      # Use callbacks to share common setup or constraints between actions.
      def set_mod
        @mod = Mod.find(params[:id])
      end

end
