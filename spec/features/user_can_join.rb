require 'spec_helper'

describe "a user can join GetHappy" do
  let(:user) { FactoryGirl.create(:user) }
  
  it "creates a new user" do
  visit root_path
  click_link "Join us!"
  fill_in :user_email, with: user.email
  fill_in :user_firstname, with: user.firstname
  fill_in :user_password, with: user.password
  fill_in :user_password_confirmation, with: user.password_confirmation
  fill_in :user_dob, with: user.dob
  click_button "Join!"
  login(user)
  within ".container" do
    expect(page).to have_content "Hello, #{user.firstname}!"
  end
end

  def login(user)
    visit "/"
    fill_in :email, with: user.email
    fill_in :password, with: user.password
    click_button "Log in!"
  end
end