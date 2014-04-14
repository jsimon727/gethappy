require 'spec_helper'

describe "a user can save favorite bars" do
  let(:user) { FactoryGirl.create(:user) }
  let(:location) { FactoryGirl.create(:location) }

  it "allows users to save their favorite bars" do

    login(user)
    visit user_path(user)
    click_link "Find Happy Hours Near Me"
    first(:button, "Favorite").click
    visit user_path(user)

    within ".editlocations" do
      expect(page).to have_content user.bars[0]["name"]
    end
  end

  def login(user)
    visit "/"
    fill_in :email, with: user.email
    fill_in :password, with: user.password
    click_button "Log in!"
  end

  def logout(user)
    click_link "Log Out"
  end

  def create_location(location)
    click_link "Add New Favorite Location"
    fill_in "Name", with: location.name
    fill_in "Zip code", with: location.zip_code
    click_button "Create Location"
  end
end