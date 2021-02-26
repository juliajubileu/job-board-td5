class Recruiter < ApplicationRecord
  belongs_to :company

  validates :email, presence: true

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  enum role: { member: 0, admin: 5 }
end


