class CarsController < ApplicationController
  def index
    @cars = Car.where(operational: true)
  end

  def show
    @car = Car.find(params[:id])
  end

  def edit
    @car = Car.find(params[:id])
  end

  def update
    car = Car.find(params[:id])
    car.update({
      operational: params[:car][:operational],
      miles: params[:car][:miles],
      color: params[:car][:color],
      owner: params[:car][:owner]
    })
    car.save
    redirect_to "/cars/#{car.id}"
  end
end