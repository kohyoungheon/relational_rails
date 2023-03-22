require 'rails_helper'

RSpec.describe "/garage", type: :feature do
  #User Story 1
  describe "as a visitor, when i visit the garage index page" do
    it "displays the name of each garage" do
      visit "/garages"

      expect(page).to have_content(garage_1.name)
      expect(page).to have_content(garage_2.name)
      expect(page).to have_content(garage_3.name)
    end
  end
end