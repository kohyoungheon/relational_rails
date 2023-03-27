require 'rails_helper'

RSpec.describe "/garages/:id/cars", type: :feature do
  #User Story 5
  describe "As a visitor, when I visit the garage cars index page" do
    let!(:garage_1){Garage.create!(indoor: true, slots: 300, city:"Denver", zipcode:"80032", name:"Cherry Creek Garage")}
    let!(:car_1){garage_1.cars.create!(operational: true, miles: 44523, color: "blue", owner: "Adam")}
    let!(:car_2){garage_1.cars.create!(operational: true, miles: 14093, color: "black", owner: "Gregor")}

    it "Displays each car associated with the garage and all its attributes" do
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

  #User Story 13
  describe "As a visitor, when i visit /garages/:id/cars" do
    let!(:garage_1){Garage.create!(indoor: true, slots: 300, city:"Denver", zipcode:"80032", name:"Cherry Creek Garage")}

    it "displays a link to add a new adoptable car" do
      visit "/garages/#{garage_1.id}/cars"
      expect(page).to have_content("Add a Car")
    end

    it "when i click the link, I am taken to /garages/:id/cars/new" do
      visit "/garages/#{garage_1.id}/cars"
      click_on("add_car")
      expect(page).to have_current_path("/garages/#{garage_1.id}/cars/new")
    end

    it "displays a form to fill in car attributes" do
      visit "/garages/#{garage_1.id}/cars/new"
      expect(page).to have_content("Add a car to Garage #{garage_1.id}")
      expect(page).to have_content("Operational:")
      expect(page).to have_content("Miles:")
      expect(page).to have_content("Color:")
      expect(page).to have_content("Owner:")
    end

    it "displays a button 'Create Car!' that sends POST request" do
      visit "/garages/#{garage_1.id}/cars/new"
      expect(page).to have_selector(:button, 'Create Car!')
    end

    it "redirects to and displays new car on /garages/:id/cars" do
      visit "/garages/#{garage_1.id}/cars/new"
      choose('option1')
      fill_in('miles', with: "3331333")
      fill_in('color', with: "Midnight Blue")
      fill_in('owner', with: "Jim")
      click_on('submit')

      expect(page).to have_current_path("/garages/#{garage_1.id}/cars")
      expect(page).to have_content("Operational: true")
      expect(page).to have_content("Miles: 3331333")
      expect(page).to have_content("Color: Midnight Blue")
      expect(page).to have_content("Owner: Jim")
    end
  end

  #User Story 16
  describe "As a visitor, when I visit /garages/:id/cars" do
    let!(:garage_1){Garage.create!(indoor: true, slots: 300, city:"Denver", zipcode:"80032", name:"Cherry Creek Garage")}
    let!(:car_1){garage_1.cars.create!(operational: true, miles: 44523, color: "blue", owner: "Xavier")}
    let!(:car_2){garage_1.cars.create!(operational: true, miles: 14093, color: "black", owner: "Gregor")}
    let!(:car_3){garage_1.cars.create!(operational: true, miles: 93324, color: "brown", owner: "Alex")}

    it "has a link called Sort Alphabetically" do
      visit "/garages/#{garage_1.id}/cars"
      expect(page).to have_content("Sort Alphabetically")
      expect(car_1.owner).to appear_before(car_2.owner)
      expect(car_2.owner).to appear_before(car_3.owner)

    end

    it"clicking the link takes me back to /garages/:id/cars, where cars are sorted" do
      visit "/garages/#{garage_1.id}/cars"
      click_on("sort")
      expect(page).to have_current_path("/garages/#{garage_1.id}/cars/?sort=true")
      expect(car_3.owner).to appear_before(car_2.owner)
      expect(car_2.owner).to appear_before(car_1.owner)
    end
  end

  #User Story 18
  describe "As a visitor, when I visit /garages/:id/cars" do
    let!(:garage_1){Garage.create!(indoor: true, slots: 300, city:"Denver", zipcode:"80032", name:"Cherry Creek Garage")}
    let!(:car_1){garage_1.cars.create!(operational: true, miles: 44523, color: "blue", owner: "Adam")}
    let!(:car_2){garage_1.cars.create!(operational: true, miles: 14093, color: "black", owner: "Gregor")}
    let!(:car_3){garage_1.cars.create!(operational: true, miles: 4277, color: "white", owner: "Mose")}

    it "has a link next to each car called Edit Car" do
      visit "/garages/#{garage_1.id}/cars/"
      expect(page).to have_content("Edit Car #{car_1.id}")
      expect(page).to have_content("Edit Car #{car_2.id}")
      expect(page).to have_content("Edit Car #{car_3.id}")
    end

    it "redirects to /garages/:id/cars/edit" do
      visit "/garages/#{garage_1.id}/cars/"
      click_on("#{car_1.id}_edit")
      expect(page).to have_current_path("/cars/#{car_1.id}/edit")

      visit "/garages/#{garage_1.id}/cars/"
      click_on("#{car_2.id}_edit")
      expect(page).to have_current_path("/cars/#{car_2.id}/edit")

      visit "/garages/#{garage_1.id}/cars/"
      click_on("#{car_3.id}_edit")
      expect(page).to have_current_path("/cars/#{car_3.id}/edit")
    end
  end

  #User Story 21
  describe "As a visitor, when i visit /garages/:id/cars" do
    let!(:garage_1){Garage.create!(indoor: true, slots: 300, city:"Denver", zipcode:"80032", name:"Cherry Creek Garage")}
    let!(:car_1){garage_1.cars.create!(operational: true, miles: 44523, color: "blue", owner: "Adam")}
    let!(:car_2){garage_1.cars.create!(operational: true, miles: 14093, color: "black", owner: "Gregor")}
    let!(:car_3){garage_1.cars.create!(operational: true, miles: 4277, color: "white", owner: "Mose")}

    it "displays a form that allows me to input a number value and submit button" do
      visit "/garages/#{garage_1.id}/cars"
      expect(page).to have_content("Return records with more than:")
      expect(page).to have_selector("input[id='filter_miles']")
    end

    it "when clicked, it redirects to same page and returns records with more Miles than entered value" do
      visit "/garages/#{garage_1.id}/cars"
      fill_in('filter_miles', with: "40000")
      click_on("submit_filter")
      expect(page).to have_current_path("/garages/#{garage_1.id}/cars/?miles=40000")

      expect(page).to have_content("Owner: Adam")
      expect(page).to have_content("Miles: 44523")

      expect(page).to_not have_content("Owner: Gregor")
      expect(page).to_not have_content("Miles: 14093")
      expect(page).to_not have_content("Owner: Mose")
      expect(page).to_not have_content("Miles: 4277")

    end
  end
end