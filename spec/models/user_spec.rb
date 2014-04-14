require 'spec_helper'

describe User do
  it { should have_many(:favorites) }
  it { should have_many(:locations), through: :favorites }
  
  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:firstname) }
end
  
