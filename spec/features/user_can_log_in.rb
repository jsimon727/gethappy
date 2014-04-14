require 'spec_helper'

describe "a user can log in" do
  let(:user) { FactoryGirl.create(:user) }

  it "allows a user to log in" do
    login(user)
    visit user_path(user)
  end

  def login(user)
    visit "/"
    fill_in :email, with: user.email
    fill_in :password, with: user.password
    click_button "Log in!"
  end
end































