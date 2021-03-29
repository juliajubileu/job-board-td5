class Job < ApplicationRecord
  belongs_to :company
  has_many :job_applications, dependent: :destroy
  has_many :candidates, through: :job_applications

  validates :title, :description, :remuneration, :level, :requirements,
            :expiration_date, :spots_available, presence: true
  validate :remuneration_cannot_be_less_than_minimum_wage,
           :expiration_date_cannot_be_in_the_past,
           :spots_cannot_be_negative
  after_find :spots_unavailable

  enum status: { enabled: 0, disabled: 1 }, _default: 'enabled'

  def remuneration_cannot_be_less_than_minimum_wage
    if remuneration.present? && remuneration < 1100
      errors.add(:remuneration,
                 :minimum_wage)
    end
  end

  def expiration_date_cannot_be_in_the_past
    if expiration_date.present? && expiration_date < Time.zone.today
      errors.add(:expiration_date,
                 :past_expiration)
    end
  end

  def spots_cannot_be_negative
    if spots_available.present? && spots_available < 1
      errors.add(:spots_available,
                 :negative_spots)
    end
  end

  def spots_unavailable
    # disabled! if job_applications.offer.accepted.count >= spots_available
  end
end
