class Candidate < ApplicationRecord
  has_many :job_applications, dependent: :destroy
  has_many :jobs, through: :job_applications

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :full_name, :cpf, :bio, :email, presence: true
  validates :cpf, :email, uniqueness: true
end
