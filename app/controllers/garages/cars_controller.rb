class Garages::CarsController < ApplicationController
  def index
    @garage = Garage.find(params[:id])
    @cars = @garage.cars

    if params['miles']
      @cars = @cars.where("miles > #{params['miles']}")
    end

    if params['sort']
      @cars = @cars.order(:owner)
    end
  
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