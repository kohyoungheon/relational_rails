class GaragesController < ApplicationController
  def index
    @garages = Garage.all
  end

  def show
    @garage = Garage.find(params[:id])
  end

  def children
    @garage = Garage.find(params[:id])
    @children = Car.all
  end
end