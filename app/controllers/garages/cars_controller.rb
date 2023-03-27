class Garages::CarsController < ApplicationController
  def index
    @garage = Garage.find(params[:id])
    @cars = @garage.sort_alphabetically(params)
  end

  def new
    @garage = Garage.find(params[:id])
  end

  def create
    @garage = Garage.find(params[:id])
    car = @garage.cars.new({
      operational: params[:car][:operational],
      miles: params[:car][:miles],
      color: params[:car][:color],
      owner: params[:car][:owner],
      })
      car.save

      redirect_to "/garages/#{@garage.id}/cars"
  end

end