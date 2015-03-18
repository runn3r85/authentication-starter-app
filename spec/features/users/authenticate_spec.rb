require 'rails_helper'

RSpec.feature "Signing In", :type => :feature do
  let(:user) { create(:user) }

  it "signs in the user and goes to dashboard" do
    sign_in(user, password: "math1234")
    expect(page).to have_content("Thank you for signing in!")
    expect(page).to have_content("My Dashboard")
  end

  it "displays the e-mail address if failed sign in" do
    sign_in(user, password: "incorrect")
    expect(page).to have_content("Please check your email and password")
    expect(page).to have_field("Email Address", with: user.email)
  end
end