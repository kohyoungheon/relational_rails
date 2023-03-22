require 'rails_helper'

RSpec.describe Car, type: :model do
  describe "relationships" do
    it { should belong_to :garage }
  end

  #User Story 5
  describe "instance methods" do
    let!(:garage_1){Garage.create!(indoor: true, slots: 300, city:"Denver", zipcode:"80032", name:"Cherry Creek Garage")}
    let!(:car_1){garage_1.cars.create!(operational: true, miles: 44523, color: "blue", owner: "Adam")}
    let!(:car_2){garage_1.cars.create!(operational: true, miles: 14093, color: "black", owner: "Gregor")}

    let!(:garage_2){Garage.create!(indoor: false, slots: 12, city:"Boulder", zipcode:"80234", name:"Boulder Garage")}
    let!(:car_3){garage_2.cars.create!(operational: true, miles: 1093, color: "brown", owner: "Sam")}
    let!(:car_4){garage_2.cars.create!(operational: true, miles: 13, color: "red", owner: "Bob")}

    it "#get_cars" do

      expect(garage_1.get_cars).to eq([car_1, car_2])

      expect(garage_2.get_cars).to eq([car_3, car_4])
    end
  end
end