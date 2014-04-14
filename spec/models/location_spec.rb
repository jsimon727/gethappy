require 'spec_helper'

describe Location do
  it { should have_many(:favorites) }
  it { should have_many(:users).through(:favorites) }
  it { should have_many(:bars) }
  it { should have_many(:deals) }
  
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:zip_code) }

end