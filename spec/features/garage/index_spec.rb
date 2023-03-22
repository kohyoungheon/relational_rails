require 'rails_helper'

RSpec.describe "/garages", type: :feature do
  #User Story 1
  describe "as a visitor, when i visit the garage index page" do
    let!(:garage_1){Garage.create!(indoor: true, slots: 300, city:"Denver", zipcode:"80032", name:"Cherry Creek Garage")}
    let!(:garage_2){Garage.create!(indoor: true, slots: 512, city:"Denver", zipcode:"80234", name:"Lakewood Garage")}
    let!(:garage_3){Garage.create!(indoor: false, slots: 800, city:"Boulder", zipcode:"81032", name:"Boulder Garage")}

    it "displays the name of each garage" do
      visit "/garages"

      # save_and_open_page
      expect(page).to have_content(garage_1.name)
      expect(page).to have_content(garage_2.name)
      expect(page).to have_content(garage_3.name)
    end
  end

  #User Story 6
  describe "as a visitor, when I visit /garages" do
    let!(:garage_1){Garage.create!(indoor: true, slots: 300, city:"Denver", zipcode:"80032", name:"Cherry Creek Garage")}
    let!(:garage_2){Garage.create!(indoor: true, slots: 512, city:"Denver", zipcode:"80234", name:"Lakewood Garage")}
    let!(:garage_3){Garage.create!(indoor: false, slots: 800, city:"Boulder", zipcode:"81032", name:"Boulder Garage")}
  
    it "orders by most recently created" do
      visit "/garages"
      save_and_open_page
      
    end

    # it "shows when the record was created" do

    # end
  end
end