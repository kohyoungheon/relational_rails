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
    before(:each) do
    @garage_1=Garage.create!(indoor: true, slots: 300, city:"Denver", zipcode:"80032", name:"Cherry Creek Garage", created_at: 1.day.ago)
    @garage_2=Garage.create!(indoor: true, slots: 512, city:"Denver", zipcode:"80234", name:"Lakewood Garage", created_at: 2.days.ago)
    @garage_3=Garage.create!(indoor: false, slots: 800, city:"Boulder", zipcode:"81032", name:"Boulder Garage", created_at: Time.current)

    end
  
    it "orders by most recently created" do
      visit "/garages"
      # save_and_open_page

      expect(@garage_2.name).to appear_before(@garage_1.name)
      expect(@garage_1.name).to appear_before(@garage_3.name)
      
    end

    it "shows when the record was created" do
      visit "/garages"
      expect(page).to have_content("Lakewood Garage Created: #{@garage_2.created_at}")
      expect(page).to have_content("Cherry Creek Garage Created: #{@garage_1.created_at}")
      expect(page).to have_content("Boulder Garage Created: #{@garage_3.created_at}")

    end
  end
end