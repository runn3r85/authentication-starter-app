require 'rails_helper'

RSpec.describe User, type: :model do
  context "validations" do
    let(:user) { build(:user) }

    it "should require first_name" do
      expect(user).to validate_presence_of(:first_name)
    end

    it "should require last_name" do
      expect(user).to validate_presence_of(:last_name)
    end

    it "should require username" do
      expect(user).to validate_presence_of(:username)
      
    end

    it "should require email" do
      expect(user).to validate_presence_of(:email)
    end

  end



end