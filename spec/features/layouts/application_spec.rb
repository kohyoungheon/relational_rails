require 'rails_helper'

RSpec.describe "layout", type: :feature do
  #User Story 8
  #User Story 9
  describe "as a visitor, when I visit any page" do
    let!(:garage_1){Garage.create!(indoor: true, slots: 300, city:"Denver", zipcode:"80032", name:"Cherry Creek Garage")}
    let!(:car_1){garage_1.cars.create!(operational: true, miles: 44523, color: "blue", owner: "Adam")}

    it "displays a link that takes the user to /cars" do #8

      visit "/"
      expect(page).to have_content("Take me back to the cars index/garage index/welcome page!")
      click_link("cars") #ID of my <a href>
      expect(page).to have_current_path("/cars")

      visit "/cars/#{car_1.id}"
      expect(page).to have_content("Take me back to the cars index/garage index/welcome page!")
      click_link("cars") #ID of my <a href>
      expect(page).to have_current_path("/cars")
    end

    it "displays a link that takes the user to /garages" do #9

      visit "/"
      expect(page).to have_content("Take me back to the cars index/garage index/welcome page!")
      click_link("garages") #ID of my <a href>
      expect(page).to have_current_path("/garages")

      visit "/garages/#{garage_1.id}"
      expect(page).to have_content("Take me back to the cars index/garage index/welcome page!")
      click_link("garages") #ID of my <a href>
      expect(page).to have_current_path("/garages")
    end
  end
end