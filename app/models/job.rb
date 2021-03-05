class Job < ApplicationRecord
  belongs_to :company
  has_many :job_applications
  has_many :candidates, through: :job_applications 

  validates :title, :description, :remuneration, :level, :requirements,
            :expiration_date, :spots_available, presence: true
  validate :remuneration_cannot_be_less_than_minimum_wage, 
           :expiration_date_cannot_be_in_the_past, 
           :spots_cannot_be_negative

  enum status: { enabled: 0, disabled: 5 }

  def remuneration_cannot_be_less_than_minimum_wage
    if
    remuneration.present? && remuneration < 1100
    errors.add(:remuneration, 'deve ser maior que salário mínimo (R$1.100,00)')
    end
  end

  def expiration_date_cannot_be_in_the_past
    if
    expiration_date.present? && expiration_date < Date.today
    errors.add(:expiration_date, 'deve ser futura')
    end
  end

  def spots_cannot_be_negative
    if
    spots_available.present? && spots_available < 1
    errors.add(:spots_available, 'deve ser número positivo')
    end
  end

  def spots_unavailable
    if self.applications.offers.accepted.count >= self.spots_available
      self.status = disabled
    end
  end
end
