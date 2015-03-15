require 'rails_helper'

RSpec.describe User, type: :model do
  context "validations" do
    let!(:user) { build(:user) }

    it "should require first_name" do
      expect(user).to validate_presence_of(:first_name)
    end

    it "should require last_name" do
      expect(user).to validate_presence_of(:last_name)
    end

    it "should require username" do
      expect(user).to validate_presence_of(:username)
    end

    it "should require unique username" do
      expect(user).to validate_uniqueness_of(:username)
    end

    it "should require email" do
      expect(user).to validate_presence_of(:email)
    end

    it "should require unique email" do
      expect(user).to validate_uniqueness_of(:email)
    end

    it "requires a unique email (case insensitive)" do
      user.email = "TEST@example.com"
      expect(user).to validate_uniqueness_of(:email)
    end

    it "requires the e-mail address to look like an email" do
      user.email = "test"
      expect(user).to_not be_valid
    end
  end

  describe "methods" do
    let!(:user) { build(:user) }

    context "#downcase_email" do
      it "makes the email attribute lowercase" do
        user.email = "TEST@EXAMPLE.COM"
        user.downcase_email
        expect(user.email).to eq("test@example.com") 
      end

      it "downcases an e-mail before saving" do
        user.email = "TEST@EXAMPLE.COM"
        expect(user.save).to be true
        expect(user.email).to eq("test@example.com")
      end
    end
  end
end