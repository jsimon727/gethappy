require 'spec_helper'

describe Bar do
  it { should have_many(:favorites) }
  it { should have_many(:users).through(:favorites) }
  it { should have_many(:bars) }
  it { should have_many(:deals) }
  
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:zip_code) }
end

let(:api_call){"Name: Amelie Location: 22 W 8th St"}


api_call
bar.is_in_db?



