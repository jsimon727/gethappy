require 'spec_helper'

describe "a user can create favorite locations" do
  let(:user) { FactoryGirl.create(:user) }
  let(:location) { FactoryGirl.create(:location) }

  it "allows users to create their favorite locations" do
    login(user)
    visit user_path(user)
    create_location(location)

    within ".editlocations" do
      expect(page).to have_content location.name
    end
  end

  def login(user)
    visit "/"
    fill_in :email, with: user.email
    fill_in :password, with: user.password
    click_button "Log in!"
  end

  def create_location(location)
    click_link "Add New Favorite Location"
    fill_in "Name", with: location.name
    fill_in "Zip code", with: location.zip_code
    click_button "Create Location"
  end
end