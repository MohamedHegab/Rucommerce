require 'rails_helper'

RSpec.describe Product, type: :model do
  before { @product = FactoryBot.build(:product) }

  subject { @product }

  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:price) }
  it { should validate_numericality_of(:price).is_greater_than_or_equal_to(0) }

  it { should belong_to(:department) }
  it { should have_and_belong_to_many(:promotions) }
end
