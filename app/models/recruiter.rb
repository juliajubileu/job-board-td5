class Recruiter < ApplicationRecord
  belongs_to :company
  before_validation :filter_corporate_domain, :find_company

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  enum role: { member: 0, admin: 5 }

  private

  def filter_corporate_domain
    recruiter_domain = email.split('@').last

    if PERSONAL_DOMAINS.include?(recruiter_domain)
      errors.add(:email, 'deve ser corporativo.')
    end
  end

  def find_company
    domain = email.split('@').last
    company = Company.find_by(domain: domain)

    if company.nil? 
      self.role = :admin
      company = Company.create(domain: domain)
    end

    self.company = company
  end
end


