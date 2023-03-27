require 'rails_helper'

RSpec.describe "/garage/:id", type: :feature do
  #User Story 2
  describe "as a visitor, when I visit /garages/:id" do
    let!(:garage_1){Garage.create!(indoor: true, slots: 300, city:"Denver", zipcode:"80032", name:"Cherry Creek Garage")}
    let!(:garage_2){Garage.create!(indoor: true, slots: 512, city:"Denver", zipcode:"80234", name:"Lakewood Garage")}
    let!(:garage_3){Garage.create!(indoor: false, slots: 800, city:"Boulder", zipcode:"81032", name:"Boulder Garage")}

    it "displays the parent with that id and all its' attributes" do
      visit "/garages/#{garage_1.id}"
      
      expect(page).to have_content("ID: #{garage_1.id}")
      expect(page).to have_content("Slots: #{garage_1.slots}")
      expect(page).to have_content("City: #{garage_1.city}")
      expect(page).to have_content("Zipcode: #{garage_1.zipcode}")
      expect(page).to have_content("Name: #{garage_1.name}")

      expect(page).to_not have_content(garage_2.name)
      expect(page).to_not have_content(garage_2.id)
      # expect(page).to_not have_content(garage_2.slots)
      # expect(page).to_not have_content(garage_2.city)
      expect(page).to_not have_content(garage_2.zipcode)

      expect(page).to_not have_content(garage_3.name)
      expect(page).to_not have_content(garage_3.id)
      # expect(page).to_not have_content(garage_3.slots)
      expect(page).to_not have_content(garage_3.city)
      expect(page).to_not have_content(garage_3.zipcode)
    end
  end

  #User Story 7
  describe "as a visitor, when I visit /garages/:id" do
    let!(:garage_1){Garage.create!(indoor: true, slots: 300, city:"Denver", zipcode:"80032", name:"Cherry Creek Garage")}
    let!(:car_1){garage_1.cars.create!(operational: true, miles: 44523, color: "blue", owner: "Adam")}
    let!(:car_2){garage_1.cars.create!(operational: true, miles: 14093, color: "black", owner: "Gregor")}

    let!(:garage_2){Garage.create!(indoor: true, slots: 512, city:"Denver", zipcode:"80234", name:"Lakewood Garage")}
    let!(:car_3){garage_2.cars.create!(operational: false, miles: 4277, color: "white", owner: "Mose")}
    let!(:car_4){garage_2.cars.create!(operational: false, miles: 40937, color: "pink", owner: "Tom")}
    let!(:car_5){garage_2.cars.create!(operational: false, miles: 407, color: "pink", owner: "Tim")}

    it "displays a count of the total number of cars associated with that garage" do
      visit "/garages/#{garage_1.id}"
  
      expect(page).to have_content("Total Cars: #{garage_1.total_cars}")
      expect(page).to_not have_content("Total Cars: #{garage_2.total_cars}")

      visit "/garages/#{garage_2.id}"

      expect(page).to have_content("Total Cars: #{garage_2.total_cars}")
      expect(page).to_not have_content("Total Cars: #{garage_1.total_cars}")
    end
  end

  #User Story 10
  describe "As a visitor, when I visit /garages/:id" do
    let!(:garage_1){Garage.create!(indoor: true, slots: 300, city:"Denver", zipcode:"80032", name:"Cherry Creek Garage")}
    let!(:car_1){garage_1.cars.create!(operational: true, miles: 44523, color: "blue", owner: "Adam")}
    let!(:car_2){garage_1.cars.create!(operational: true, miles: 14093, color: "black", owner: "Gregor")}

    let!(:garage_2){Garage.create!(indoor: true, slots: 512, city:"Denver", zipcode:"80234", name:"Lakewood Garage")}
    let!(:car_3){garage_2.cars.create!(operational: false, miles: 4277, color: "white", owner: "Mose")}
    
    it "displays a link that takes the user to /garages/:id/cars" do

      visit "/garages/#{garage_1.id}"
      expect(page).to have_content("View all cars associated with this garage.")
      click_link("associated") #ID of my <a href>
      expect(page).to have_current_path("/garages/#{garage_1.id}/cars")

      visit "/garages/#{garage_2.id}"
      expect(page).to have_content("View all cars associated with this garage.")
      click_link("associated") #ID of my <a href>
      expect(page).to have_current_path("/garages/#{garage_2.id}/cars")
    end
  end

    #User Story 12
    describe "as a visitor, when I visit /garages/:id" do
      let!(:garage_1){Garage.create!(indoor: true, slots: 300, city:"Denver", zipcode:"80032", name:"Cherry Creek Garage")}
      let!(:car_1){garage_1.cars.create!(operational: true, miles: 44523, color: "blue", owner: "Adam")}
      let!(:car_2){garage_1.cars.create!(operational: true, miles: 14093, color: "black", owner: "Gregor")}

      it "displays a link to update the garage called Update Garage" do
        visit "/garages/#{garage_1.id}"
        expect(page).to have_content("Update Garage")
      end

      it "when I click the link, it redirects me to /garage/:id/edit" do
        visit "/garages/#{garage_1.id}"
        click_link("edit_garage")
        expect(page).to have_current_path("/garages/#{garage_1.id}/edit")
      end

      it "Displays a form to edit garage attributes" do
        visit "/garages/#{garage_1.id}/edit"
        expect(page).to have_content("Edit Garage #{garage_1.id}")
        expect(page).to have_content("Slots:")
        expect(page).to have_content("City:")
        expect(page).to have_content("Zipcode:")
        expect(page).to have_content("Name:")
      end

      it "sends PATCH request to /garage/:id when I submit the form and redirects to /garage/:id" do
        visit "/garages/#{garage_1.id}/edit"
        click_on("confirm_edit")
        expect(page).to have_current_path("/garages/#{garage_1.id}")
      end

      it "Updates the info and displays new info on garage/:id/cars" do
        visit "/garages/#{garage_1.id}/edit"
        fill_in('name', with: 'Big Garage')
        fill_in('slots', with: '222')
        fill_in('city', with: 'Albany')
        fill_in('zipcode', with: '90034')
        click_on("confirm_edit")
        expect(page).to have_current_path("/garages/#{garage_1.id}")

        expect(page).to have_content("Slots: 222")
        expect(page).to have_content("City: Albany")
        expect(page).to have_content("Zipcode: 90034")
        expect(page).to have_content("Name: Big Garage")
      end
    end

    #User Story 19
    describe "As a visitor, When i visit /garages/:id" do
      let!(:garage_1){Garage.create!(indoor: true, slots: 300, city:"Denver", zipcode:"80032", name:"Cherry Creek Garage")}
      let!(:car_1){garage_1.cars.create!(operational: true, miles: 44523, color: "blue", owner: "Adam")}
      let!(:car_2){garage_1.cars.create!(operational: true, miles: 14093, color: "black", owner: "Gregor")}

      let!(:garage_2){Garage.create!(indoor: true, slots: 512, city:"Denver", zipcode:"80234", name:"Lakewood Garage")}
      let!(:car_3){garage_2.cars.create!(operational: true, miles: 4277, color: "white", owner: "Mose")}


      it "displays link 'DELETE THIS GARAGE'" do
        visit "/garages/#{garage_1.id}"
        expect(page).to have_selector(:button, 'DELETE THIS GARAGE')
        visit "/garages/#{garage_2.id}"
        expect(page).to have_selector(:button, 'DELETE THIS GARAGE')
      end
      
      it "clicking the link deletes the parent(and all children) and redirects to /garages" do
        visit "/cars" #Cars index to check state before deletion (boolean set to true cars only)
        
        expect(page).to have_content("Owner: Adam")
        expect(page).to have_content("Miles: 44523")
        expect(page).to have_content("Owner: Gregor")
        expect(page).to have_content("Miles: 14093")
        expect(page).to have_content("Owner: Mose")
        expect(page).to have_content("Miles: 4277")

        visit "/garages" #Check state of Garages index before deletion
        expect(page).to have_content("Cherry Creek Garage")
        expect(page).to have_content("Lakewood Garage")

        visit "/garages/#{garage_1.id}"
        click_button('DELETE THIS GARAGE')
        expect(page).to have_current_path("/garages")
        expect(page).to have_content("Lakewood Garage")
        expect(page).to_not have_content("Cherry Creek Garage")

        visit "/cars"
        expect(page).to have_content("Owner: Mose")
        expect(page).to have_content("Miles: 4277")

        expect(page).to_not have_content("Owner: Adam")
        expect(page).to_not have_content("Miles: 44523")
        expect(page).to_not have_content("Owner: Gregor")
        expect(page).to_not have_content("Miles: 14093")
      end
    end
end