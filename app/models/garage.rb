class Garage < ApplicationRecord
  has_many :cars, :dependent => :destroy

  def get_cars
    cars.order(:garage_id)
  end

  def total_cars
    cars.count
  end
  
  def sort_alphabetically(params)
    @cars = self.cars
    if params['miles']
      @cars = @cars.where("miles > #{params['miles']}")
    end
  
    if params['sort']
      @cars = @cars.order(:owner)
    end
    @cars
  end
  
end