class Garage < ApplicationRecord
  has_many :cars

  def get_cars
    cars.order(:garage_id)
  end

end