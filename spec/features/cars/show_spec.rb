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

  #User Story 14
  describe "As a visitor, when i visit /cars/:id " do
    let!(:garage_1){Garage.create!(indoor: true, slots: 300, city:"Denver", zipcode:"80032", name:"Cherry Creek Garage")}
    let!(:car_1){garage_1.cars.create!(operational: true, miles: 44523, color: "blue", owner: "Adam")}

    it "displays a link, 'Update Car' to update child" do
      visit "/cars/#{car_1.id}"
      expect(page).to have_content("Update Car")
    end

    it "clicking the link takes visitor to /cars/:id/edit" do
      visit "/cars/#{car_1.id}"
      click_link("edit_car")
      expect(page).to have_current_path("/cars/#{car_1.id}/edit")
    end

    it "displays a form with car attributes filled in, to edit" do
      visit "/cars/#{car_1.id}/edit"
        expect(page).to have_content("Edit Car #{car_1.id}")
        expect(page).to have_content("Miles:")
        expect(page).to have_content("Color:")
        expect(page).to have_content("Owner:")
    end
    it "Displays a button called 'Update Car'" do
      visit "/cars/#{car_1.id}/edit"
      expect(page).to have_selector(:button, 'Update Car')
    end

    it "clicking 'Update Child' updates data and redirects to show page" do
      visit "/cars/#{car_1.id}/edit"

      choose('option1')
      fill_in('miles', with: 100001)
      fill_in('color', with: "Rainbow")
      fill_in('owner', with: "Jean Baptiste")
      click_on('confirm_edit')

      expect(page).to have_current_path("/cars/#{car_1.id}")

      expect(page).to have_content("Miles: 100001")
      expect(page).to have_content("Color: Rainbow")
      expect(page).to have_content("Owner: Jean Baptiste")

    end
  end
end