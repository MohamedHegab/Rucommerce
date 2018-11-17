class Promotion < ApplicationRecord
  has_and_belongs_to_many :products
  validates_presence_of :code, :percent, :start_date, :end_date
  validates_numericality_of :percent, greater_than_or_equal_to: 0
  validate :end_date_is_after_start_date

  def self.active
    where('start_date >= ? AND end_date <= ?', Time.now, Time.now)
  end

  private

  def end_date_is_after_start_date
    return if end_date.nil? || start_date.nil?

    if end_date < start_date
      errors.add(:end_date, 'cannot be before the start date')
    end
  end
end
