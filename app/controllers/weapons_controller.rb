class WeaponsController < ApplicationController
	
	before_action :set_weapon

	def index
		@weapons = Weapon.all
	end

	def create
		@weapon = Weapon.create(weapon_params)
		redirect_to users_path
	end

	def destroy
		@weapon.destroy
		head 204
	end

	def show
		@weapon_show = Weapon.where("id = ? ", params[:id])
	end
	
	private

	def weapon_params
		params.permit(:name, :description, :power_base, :power_step, :level)
	end

	def set_weapon
		@weapon = Weapon.find(params[:id])
	rescue ActiveRecord::RecordNotFound => e
		render json: { message: e.message }, status: :not_found
	end
	end
end