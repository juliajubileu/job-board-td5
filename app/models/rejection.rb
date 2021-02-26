class Rejection < ApplicationRecord
  belongs_to :application

  validates :motive, presence: true
end
