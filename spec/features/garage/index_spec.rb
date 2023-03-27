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

      expect(@garage_3.name).to appear_before(@garage_1.name)
      expect(@garage_1.name).to appear_before(@garage_2.name)
      
    end

    it "shows when the record was created" do
      visit "/garages"
      expect(page).to have_content("Lakewood Garage Created: #{@garage_2.created_at}")
      expect(page).to have_content("Cherry Creek Garage Created: #{@garage_1.created_at}")
      expect(page).to have_content("Boulder Garage Created: #{@garage_3.created_at}")

    end
  end

  #User Story 11
  it "shows a link to create a new Garage. 'Create New Garage' " do
    visit "/garages"
    expect(page).to have_content("Create New Garage")
  end
  
  it "clicking New Garage takes User to /garage/new" do
    visit "/garages"
    click_link("new_garage") #ID of my <a href>
    expect(page).to have_current_path("/garages/new")
  end

  it "Displays a form to input garage attributes" do
    visit "/garages/new"
    expect(page).to have_content("Create a New Garage!")
    expect(page).to have_content("Indoor:")
    expect(page).to have_content("True")
    expect(page).to have_content("False")
    expect(page).to have_content("Slots:")
    expect(page).to have_content("City:")
  end

  it "Displays a 'Create Garage' button" do
    visit "/garages/new"
    expect(page).to have_selector(:button, 'Create Garage')
  end

  it "sends POST request to /parents and creates a new record" do
    visit "/garages/new"
    choose('option1')
    fill_in('slots', with: 55)
    fill_in('city', with: "LA")
    fill_in('zipcode', with: "80017")
    fill_in('name', with: "LA Garage")
    click_on('submit')
    expect(page).to have_current_path("/garages")

  end

  it "redirects to the parent index page and displays newly created parent" do
    visit "/garages/new"
    choose('option1')
    fill_in('slots', with: 55)
    fill_in('city', with: "LA")
    fill_in('zipcode', with: "80017")
    fill_in('name', with: "LA Garage")
    click_on('submit')
    expect(page).to have_current_path("/garages")

    expect(page).to have_content("LA Garage Created:")
  end

  #User Story 17
  describe "as a user, when i visit /garages" do
    let!(:garage_1){Garage.create!(indoor: true, slots: 300, city:"Denver", zipcode:"80032", name:"Cherry Creek Garage")}
    let!(:garage_2){Garage.create!(indoor: true, slots: 512, city:"Denver", zipcode:"80234", name:"Lakewood Garage")}
    let!(:garage_3){Garage.create!(indoor: false, slots: 800, city:"Boulder", zipcode:"81032", name:"Boulder Garage")}

    it "displays edit next to each garage" do
      visit "/garages"
      expect(page).to have_content(garage_1.name)
      expect(page).to have_content("Edit Garage #{garage_1.id}")
      expect(page).to have_content(garage_2.name)
      expect(page).to have_content("Edit Garage #{garage_2.id}")
      expect(page).to have_content(garage_3.name)
      expect(page).to have_content("Edit Garage #{garage_3.id}")
    end

    it "clicking edit takes the user to that garages/:id/edit" do
      visit "/garages"
      click_on("#{garage_1.id}_edit")
      expect(page).to have_current_path("/garages/#{garage_1.id}/edit")
  
      visit "/garages"
      click_on("#{garage_2.id}_edit")
      expect(page).to have_current_path("/garages/#{garage_2.id}/edit")
  
      visit "/garages"
      click_on("#{garage_3.id}_edit")
      expect(page).to have_current_path("/garages/#{garage_3.id}/edit")
    end
  end

  # User Story 22
  describe "as a user, when i visit /garages" do
    let!(:garage_1){Garage.create!(indoor: true, slots: 300, city:"Denver", zipcode:"80032", name:"Cherry Creek Garage")}
    let!(:garage_2){Garage.create!(indoor: true, slots: 512, city:"Denver", zipcode:"80234", name:"Lakewood Garage")}
    let!(:garage_3){Garage.create!(indoor: false, slots: 800, city:"Boulder", zipcode:"81032", name:"Boulder Garage")}

    it "displays a link next to each garage called 'DELETE THIS GARAGE!'" do
      visit "/garages"
      expect(page).to have_content("#{garage_1.name} Created:")
      expect(page).to have_selector(:button, "delete_#{garage_1.id}")
      expect(page).to have_content("#{garage_2.name} Created:")
      expect(page).to have_selector(:button, "delete_#{garage_2.id}")
      expect(page).to have_content("#{garage_3.name} Created:")
      expect(page).to have_selector(:button, "delete_#{garage_3.id}")
    end

    it "clicking the link deletes garage and redirects to /garages,and displays updated records" do
      visit "/garages"
      click_on("delete_#{garage_3.id}")
      expect(page).to have_current_path("/garages")

      expect(page).to have_content("#{garage_1.name} Created:")
      expect(page).to have_selector(:button, "delete_#{garage_1.id}")
      expect(page).to have_content("#{garage_2.name} Created:")
      expect(page).to have_selector(:button, "delete_#{garage_2.id}")

      expect(page).to_not have_content("#{garage_3.name} Created:")
      expect(page).to_not have_selector(:button, "delete_#{garage_3.id}")

      visit "/garages"
      click_on("delete_#{garage_2.id}")
      expect(page).to have_current_path("/garages")

      expect(page).to have_content("#{garage_1.name} Created:")
      expect(page).to have_selector(:button, "delete_#{garage_1.id}")

      expect(page).to_not have_content("#{garage_2.name} Created:")
      expect(page).to_not have_selector(:button, "delete_#{garage_2.id}")
      expect(page).to_not have_content("#{garage_3.name} Created:")
      expect(page).to_not have_selector(:button, "delete_#{garage_3.id}")
    end
  end

end