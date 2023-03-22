require 'rails_helper'

RSpec.describe "/garages/:id/cars", type: :feature do
  #User Story 5
  describe "As a visitor, when I visit the garage cars index page" do
    let!(:garage_1){Garage.create!(indoor: true, slots: 300, city:"Denver", zipcode:"80032", name:"Cherry Creek Garage")}
    let!(:car_1){garage_1.cars.create!(operational: true, miles: 44523, color: "blue", owner: "Adam")}
    let!(:car_2){garage_1.cars.create!(operational: true, miles: 14093, color: "black", owner: "Gregor")}

    it "Displays a each car associated with the garage and all its attributes" do
      visit "/garages/#{garage_1.id}/cars"
      # save_and_open_page

      expect(page).to have_content("ID: #{car_1.id}")
      expect(page).to have_content("Operational: #{car_1.operational}")
      expect(page).to have_content("Miles: #{car_1.miles}")
      expect(page).to have_content("Color: #{car_1.color}")
      expect(page).to have_content("Owner: #{car_1.owner}")

      expect(page).to have_content("ID: #{car_2.id}")
      expect(page).to have_content("Operational: #{car_2.operational}")
      expect(page).to have_content("Miles: #{car_2.miles}")
      expect(page).to have_content("Color: #{car_2.color}")
      expect(page).to have_content("Owner: #{car_2.owner}")
    end
  end
end