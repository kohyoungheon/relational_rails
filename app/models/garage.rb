class Garage < ApplicationRecord
  has_many :cars, :dependent => :destroy

  def get_cars
    cars.order(:garage_id)
  end

  def total_cars
    cars.count
  end
  
end