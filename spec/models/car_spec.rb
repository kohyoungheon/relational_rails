require 'rails_helper'

RSpec.describe Car, type: :model do
  describe "relationships" do
    it { should belong_to :garage }
  end
end