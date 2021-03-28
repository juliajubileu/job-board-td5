class Offer < ApplicationRecord
  belongs_to :job_application
  has_one :denial, dependent: :destroy

  validates :message, :salary, :starting_date, presence: true

  validate :salary_cannot_be_less_than_minimum_wage,
           :starting_date_cannot_be_in_the_past

  enum status: { pending: 0, accepted: 3, denied: 5 }

  def salary_cannot_be_less_than_minimum_wage
    errors.add(:salary, :minimum_wage) if salary.present? && salary < 1100
  end

  def starting_date_cannot_be_in_the_past
    if starting_date.present? && starting_date < Time.zone.today
      errors.add(:starting_date,
                 :past_date)
    end
  end
end
