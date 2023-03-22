require 'rails_helper'

RSpec.describe Garage, type: :model do
  describe "relationships" do
    it { should have_many :cars }
  end
end