class Recruiter < ApplicationRecord
  belongs_to :company

  validates :email, presence: true
  #validate :email_cant_be_personal

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  enum role: { member: 0, admin: 5}
end


  #PERSONAL_DOMAINS = ['gmail.com', 'yahoo.com', 'hotmail.com', 'outlook.com',
  #                   'uol.com.br', 'ig.com.br']
                     
  #def email_cant_be_personal 
  #  if PERSONAL_DOMAINS.any? { |domain| email.end_with?(domain)}
  #   errors.add(:email, 'Não é e-mail corporativo')
  #  end
  #end