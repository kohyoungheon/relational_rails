require 'rails_helper'

RSpec.describe "/cars", type: :feature do
  #User Story 3
  describe "as a visitor, when I visit the Cars index page" do
    let!(:garage_1){Garage.create!(indoor: true, slots: 300, city:"Denver", zipcode:"80032", name:"Cherry Creek Garage")}
    let!(:car_1){garage_1.cars.create!(operational: true, miles: 44523, color: "blue", owner: "Adam")}
    let!(:car_2){garage_1.cars.create!(operational: true, miles: 14093, color: "black", owner: "Gregor")}
    let!(:car_3){garage_1.cars.create!(operational: false, miles: 204011, color: "orange", owner: "Sandor")}

    it "displays the name of each car" do
      visit "/cars"

      # save_and_open_page
      expect(page).to have_content("ID: #{car_1.id}")
      expect(page).to have_content("ID: #{car_2.id}")
      expect(page).to have_content("ID: #{car_3.id}")
    end
  end
end