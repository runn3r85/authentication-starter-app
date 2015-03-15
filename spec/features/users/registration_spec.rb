require "rails_helper"

RSpec.feature "Registering", :type => :feature do

  def fill_in_form(options={})
    options[:first_name] ||= "Test"
    options[:last_name] ||= "User"
    options[:username] ||= "TestUser"
    options[:email] ||= "test@example.com"
    options[:password] ||= "math1234"
    options[:password_confirmation] ||= "math1234"

    expect(User.count).to eq(0)

    visit "/"
    expect(page).to have_content("Sign Up")
    click_link "Sign Up"

    fill_in "First Name", with: options[:first_name]
    fill_in "Last Name", with: options[:last_name]
    fill_in "Username", with: options[:username]
    fill_in "Email", with: options[:email]
    fill_in "Password", with: options[:password]
    fill_in "Password (again)", with: options[:password_confirmation]

    click_button "Sign Up"
  end


  it "allows a user to sign up" do
    fill_in_form

    expect(User.count).to eq(1)
    expect(page).to have_content("Test User")
  end

  it "errors if user doesn't fill-in first name" do
    fill_in_form(first_name: "")

    expect(User.count).to eq(0)
    expect(page).to have_content("First name can't be blank")
  end

  it "errors if user doesn't fill-in last name" do
    fill_in_form(last_name: "")

    expect(User.count).to eq(0)
    expect(page).to have_content("Last name can't be blank")
  end

  it "errors if user doesn't fill-in username" do
    fill_in_form(username: "")

    expect(User.count).to eq(0)
    expect(page).to have_content("Username can't be blank")
  end

  it "errors if user doesn't fill-in email" do
    fill_in_form(email: "")

    expect(User.count).to eq(0)
    expect(page).to have_content("Email can't be blank")
  end

  it "errors if email is not proper format" do
    fill_in_form(email: "test")

    expect(User.count).to eq(0)
    expect(page).to have_content("Must be a valid e-mail format")
  end

  it "errors if passwords don't match" do
    fill_in_form(password_confirmation: "1234")

    expect(User.count).to eq(0)
    expect(page).to have_content("Password confirmation doesn't match Password")
  end

  it "errors if password is missing" do
    fill_in_form(password: "")

    expect(User.count).to eq(0)
    expect(page).to have_content("Password can't be blank")
  end
end