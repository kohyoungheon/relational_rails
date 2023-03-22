class Garages::CarsController < ApplicationController
  def index
    @garage = Garage.find(params[:id])
  end
end