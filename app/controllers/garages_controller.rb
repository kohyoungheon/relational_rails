class GaragesController < ApplicationController
  def index
    @garages = Garage.all.order(created_at: :desc)
    if params["childsort"]
      @garages = Garage.left_joins(:cars)
                        .select("garages.*, count(cars.id) as cars_count")
                        .group("garages.id")
                        .order("cars_count DESC")
    end
  end

  def show
    @garage = Garage.find(params[:id])
  end

  def new

  end

  def create
    garage = Garage.new({
      indoor: params[:garage][:indoor],
      slots: params[:garage][:slots],
      city: params[:garage][:city],
      zipcode: params[:garage][:zipcode],
      name: params[:garage][:name],
    })

    garage.save
    redirect_to '/garages'
  end

  def edit
    @garage = Garage.find(params[:id])
  end

  def update
    garage = Garage.find(params[:id])
    garage.update({
      indoor: params[:garage][:indoor],
      slots: params[:garage][:slots],
      city: params[:garage][:city],
      zipcode: params[:garage][:zipcode],
      name: params[:garage][:name],
    })
    garage.save
    redirect_to "/garages/#{garage.id}"
  end
  
  def destroy
    Garage.destroy(params[:id])
    redirect_to "/garages"
  end
end