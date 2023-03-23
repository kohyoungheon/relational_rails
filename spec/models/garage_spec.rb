require 'rails_helper'

RSpec.describe Garage, type: :model do
  describe "relationships" do
    it { should have_many :cars }
  end

  #User Story 7
  describe "#total_cars" do
    let!(:garage_1){Garage.create!(indoor: true, slots: 300, city:"Denver", zipcode:"80032", name:"Cherry Creek Garage")}
    let!(:car_1){garage_1.cars.create!(operational: true, miles: 44523, color: "blue", owner: "Adam")}
    let!(:car_2){garage_1.cars.create!(operational: true, miles: 14093, color: "black", owner: "Gregor")}

    let!(:garage_2){Garage.create!(indoor: true, slots: 512, city:"Denver", zipcode:"80234", name:"Lakewood Garage")}
    let!(:car_3){garage_2.cars.create!(operational: false, miles: 4277, color: "white", owner: "Mose")}
    let!(:car_4){garage_2.cars.create!(operational: false, miles: 40937, color: "pink", owner: "Tom")}
    let!(:car_5){garage_2.cars.create!(operational: false, miles: 937, color: "purple", owner: "Jim")}
    
    it "returns a count of cars associated with the garage" do

      expect(garage_1.total_cars).to eq(2)
      expect(garage_2.total_cars).to eq(3)
      
    end
  end
end