class Candidate < ApplicationRecord
  has_many :applications
  has_many :jobs, through: :applications

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :full_name, :cpf, :bio, :email, presence: true
  validates :cpf, :email, uniqueness: true
end
