class Offer < ApplicationRecord
  belongs_to :job_application
  has_one :denial

  validates :message, :salary, :starting_date, presence: true

  validate :salary_cannot_be_less_than_minimum_wage, :starting_date_cannot_be_in_the_past

  enum status: { pending: 0, accepted: 3, denied: 5 }

  def salary_cannot_be_less_than_minimum_wage
    if
    salary.present? && salary < 1100
    errors.add(:salary, 'deve ser maior que salário mínimo (R$1.100,00)')
    end
  end

  def starting_date_cannot_be_in_the_past
    if
    starting_date.present? && starting_date < Date.today
    errors.add(:starting_date, 'deve ser futura')
    end
  end

end
