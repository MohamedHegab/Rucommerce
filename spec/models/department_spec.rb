require 'rails_helper'

RSpec.describe Department, type: :model do
  before { @department = FactoryBot.build(:department) }

  subject { @department }

  it { should validate_presence_of(:name) }
  it { should have_many(:products).dependent(:destroy) }
end
