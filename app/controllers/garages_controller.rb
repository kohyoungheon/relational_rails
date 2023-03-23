class GaragesController < ApplicationController
  def index
    @garages = Garage.all.order(created_at: :asc)
  end

  def show
    @garage = Garage.find(params[:id])
  end

  
end