require 'rails_helper'

RSpec.describe Promotion, type: :model do
  before { @promotion = FactoryBot.build(:promotion) }

  subject { @promotion }

  it { should validate_presence_of(:code) }
  it { should validate_presence_of(:start_date) }
  it { should validate_presence_of(:end_date) }
  it { should validate_presence_of(:percent) }
  it { should validate_numericality_of(:percent).is_greater_than_or_equal_to(0) }
  it { should have_and_belong_to_many(:products) }

  it 'validate that end_date is after start_date' do
    subject.start_date = Date.today
    subject.end_date = Date.today - 1
    subject.valid?
    expect(subject.errors[:end_date]).to include('cannot be before the start date')
  end
end
