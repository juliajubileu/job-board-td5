class Recruiter < ApplicationRecord
  PERSONAL_DOMAINS = ['gmail.com']

  validates :email, presence: true
  validate :email_cant_be_personal

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def email_cant_be_personal 
    if PERSONAL_DOMAINS.any? { |domain| email.end_with?(domain)}
      errors.add(:email, 'Não é e-mail corporativo')
    end
  end
end
