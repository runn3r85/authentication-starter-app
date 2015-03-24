require 'rails_helper'

RSpec.describe "users/show", type: :view do
  before(:each) do
    @user = assign(:user, create(:user))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(@user.first_name)
    expect(rendered).to match(@user.last_name)
  end
end
