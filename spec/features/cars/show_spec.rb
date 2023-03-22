require 'rails_helper'

RSpec.describe "/cars/:id", type: :feature do
  #User Story 4
  describe "as a visitor, when I visit /cars/:id" do
    let!(:garage_1){Garage.create!(indoor: true, slots: 300, city:"Denver", zipcode:"80032", name:"Cherry Creek Garage")}
    let!(:car_1){garage_1.cars.create!(operational: true, miles: 44523, color: "blue", owner: "Adam")}
    let!(:car_2){garage_1.cars.create!(operational: true, miles: 14093, color: "black", owner: "Gregor")}
    let!(:car_3){garage_1.cars.create!(operational: false, miles: 204011, color: "orange", owner: "Sandor")}

    it "displays the car with that id including the car's attributes" do
      visit "/cars/#{car_1.id}"

      # save_and_open_page

      expect(page).to have_content("ID: #{car_1.id}")
      expect(page).to have_content("Operational: #{car_1.operational}")
      expect(page).to have_content("Miles: #{car_1.miles}")
      expect(page).to have_content("Color: #{car_1.color}")
      expect(page).to have_content("Owner: #{car_1.owner}")

      expect(page).to_not have_content(car_2.id)
      expect(page).to_not have_content(car_3.id)

    end
  end
end