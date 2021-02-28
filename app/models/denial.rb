class Denial < ApplicationRecord
  belongs_to :offer

  validates :motive, presence: true
end
