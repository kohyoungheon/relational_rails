require 'rails_helper'

RSpec.describe "/garage/:id", type: :feature do
  #User Story 2
  describe "as a visitor, when I visit /garage/:id" do
    let!(:garage_1){Garage.create!(indoor: true, slots: 300, city:"Denver", zipcode:"80032", name:"Cherry Creek Garage")}
    let!(:garage_2){Garage.create!(indoor: true, slots: 512, city:"Denver", zipcode:"80234", name:"Lakewood Garage")}
    let!(:garage_3){Garage.create!(indoor: false, slots: 800, city:"Boulder", zipcode:"81032", name:"Boulder Garage")}

    it "displays the parent with that id and all its' attributes" do
      visit "/garages/#{garage_1.id}"
      
      expect(page).to have_content(garage_1.id)
      expect(page).to have_content(garage_1.slots)
      expect(page).to have_content(garage_1.city)
      expect(page).to have_content(garage_1.zipcode)
      expect(page).to have_content(garage_1.name)

      expect(page).to_not have_content(garage_2.name)
      expect(page).to_not have_content(garage_3.name)
    end
  end
end