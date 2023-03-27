require 'rails_helper'

RSpec.describe "/cars", type: :feature do
  #User Story 3
  describe "as a visitor, when I visit the Cars index page" do
    let!(:garage_1){Garage.create!(indoor: true, slots: 300, city:"Denver", zipcode:"80032", name:"Cherry Creek Garage")}
    let!(:car_1){garage_1.cars.create!(operational: true, miles: 44523, color: "blue", owner: "Adam")}
    let!(:car_2){garage_1.cars.create!(operational: true, miles: 14093, color: "black", owner: "Gregor")}
    let!(:car_3){garage_1.cars.create!(operational: true, miles: 204011, color: "orange", owner: "Sandor")}

    it "displays the name of each car" do
      visit "/cars"

      # save_and_open_page
      expect(page).to have_content("ID: #{car_1.id}")
      expect(page).to have_content("ID: #{car_2.id}")
      expect(page).to have_content("ID: #{car_3.id}")
    end
  end

  #User Story 15
  describe "as a visitor, When i visit /cars" do
    let!(:garage_1){Garage.create!(indoor: true, slots: 300, city:"Denver", zipcode:"80032", name:"Cherry Creek Garage")}
    let!(:car_1){garage_1.cars.create!(operational: true, miles: 44523, color: "blue", owner: "Adam")}
    let!(:car_2){garage_1.cars.create!(operational: true, miles: 14093, color: "black", owner: "Gregor")}
    let!(:car_3){garage_1.cars.create!(operational: false, miles: 116787, color: "grey", owner: "Sandor")}
    let!(:car_4){garage_1.cars.create!(operational: false, miles: 299234, color: "white", owner: "Jamie")}
    let!(:car_5){garage_1.cars.create!(operational: false, miles: 42347, color: "pink", owner: "Oberyn")}
    
    it "displays records where operational: true" do
      visit "/cars"
    
      expect(page).to have_content("ID: #{car_1.id}")
      expect(page).to have_content("Color: #{car_1.color}")
      expect(page).to have_content("Owner: #{car_1.owner}")

      expect(page).to have_content("ID: #{car_2.id}")
      expect(page).to have_content("Color: #{car_2.color}")
      expect(page).to have_content("Owner: #{car_2.owner}")

      expect(page).to_not have_content("ID: #{car_3.id}")
      expect(page).to_not have_content("Color: #{car_3.color}")
      expect(page).to_not have_content("Owner: #{car_3.owner}")

      expect(page).to_not have_content("ID: #{car_4.id}")
      expect(page).to_not have_content("Color: #{car_4.color}")
      expect(page).to_not have_content("Owner: #{car_4.owner}")

      expect(page).to_not have_content("ID: #{car_5.id}")
      expect(page).to_not have_content("Color: #{car_5.color}")
      expect(page).to_not have_content("Owner: #{car_5.owner}")

    end
  end

  #User Story 18
  describe "as a visitor, when I visit /cars" do
    let!(:garage_1){Garage.create!(indoor: true, slots: 300, city:"Denver", zipcode:"80032", name:"Cherry Creek Garage")}
    let!(:car_1){garage_1.cars.create!(operational: true, miles: 44523, color: "blue", owner: "Adam")}
    let!(:car_2){garage_1.cars.create!(operational: true, miles: 14093, color: "black", owner: "Gregor")}
    let!(:car_3){garage_1.cars.create!(operational: true, miles: 204011, color: "orange", owner: "Sandor")}

    it "Next to every child, I see a link to edit that child called Edit Car" do
      visit "/cars"
      expect(page).to have_content("Edit Car #{car_1.id}")
      expect(page).to have_content("Edit Car #{car_2.id}")
      expect(page).to have_content("Edit Car #{car_3.id}")
    end

    it "redirects to /cars/:id.edit" do
      visit "/cars"
      click_link("#{car_1.id}_edit")
      expect(page).to have_current_path("/cars/#{car_1.id}/edit")

      visit "/cars"
      click_link("#{car_2.id}_edit")
      expect(page).to have_current_path("/cars/#{car_2.id}/edit")

      visit "/cars"
      click_link("#{car_3.id}_edit")
      expect(page).to have_current_path("/cars/#{car_3.id}/edit")
    end
  end

  #User Story 23 pt.1
  describe "as a visitor, when i visit /cars" do
    let!(:garage_1){Garage.create!(indoor: true, slots: 300, city:"Denver", zipcode:"80032", name:"Cherry Creek Garage")}
    let!(:car_1){garage_1.cars.create!(operational: true, miles: 44523, color: "blue", owner: "Adam")}
    let!(:car_2){garage_1.cars.create!(operational: true, miles: 14093, color: "black", owner: "Gregor")}
    let!(:car_3){garage_1.cars.create!(operational: true, miles: 204011, color: "orange", owner: "Sandor")}

    it " displays a link next to each car,'Delete Car: id'" do
      visit "/cars"
      expect(page).to have_content("Owner: #{car_1.owner}")
      expect(page).to have_content("Miles: #{car_1.miles}")
      expect(page).to have_selector(:button, "Delete Car: #{car_1.id}")

      expect(page).to have_content("Owner: #{car_2.owner}")
      expect(page).to have_content("Miles: #{car_2.miles}")
      expect(page).to have_selector(:button, "Delete Car: #{car_2.id}")

      expect(page).to have_content("Owner: #{car_3.owner}")
      expect(page).to have_content("Miles: #{car_3.miles}")
      expect(page).to have_selector(:button, "Delete Car: #{car_3.id}")
    end

    it "clicking the link deletes the car, redirects to /cars, and displays updated records" do
      visit "/cars"
      # save_and_open_page
      click_button("Delete Car: #{car_3.id}")
      expect(page).to have_current_path("/cars/")

      expect(page).to have_content("Owner: #{car_1.owner}")
      expect(page).to have_content("Miles: #{car_1.miles}")
      expect(page).to have_selector(:button, "Delete Car: #{car_1.id}")

      expect(page).to have_content("Owner: #{car_2.owner}")
      expect(page).to have_content("Miles: #{car_2.miles}")
      expect(page).to have_selector(:button, "Delete Car: #{car_2.id}")

      expect(page).to_not have_content("Owner: #{car_3.owner}")
      expect(page).to_not have_content("Miles: #{car_3.miles}")
      expect(page).to_not have_selector(:button, "Delete Car: #{car_3.id}")

      click_button("Delete Car: #{car_2.id}")
      expect(page).to have_current_path("/cars/")

      expect(page).to have_content("Owner: #{car_1.owner}")
      expect(page).to have_content("Miles: #{car_1.miles}")
      expect(page).to have_selector(:button, "Delete Car: #{car_1.id}")

      expect(page).to_not have_content("Owner: #{car_2.owner}")
      expect(page).to_not have_content("Miles: #{car_2.miles}")
      expect(page).to_not have_selector(:button, "Delete Car: #{car_2.id}")

      expect(page).to_not have_content("Owner: #{car_3.owner}")
      expect(page).to_not have_content("Miles: #{car_3.miles}")
      expect(page).to_not have_selector(:button, "Delete Car: #{car_3.id}")
    end
  end
end