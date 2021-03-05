class Rejection < ApplicationRecord
  belongs_to :job_application

  validates :motive, presence: true
end
