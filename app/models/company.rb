class Company < ApplicationRecord
    has_one_attached :logo
    
    validates :name, :address, :cnpj, :domain, :website, presence: true
    validates :name, :cnpj, :domain, uniqueness: true

    before_validation :set_domain

    def find_by_domain(domain)
        Company.find_by domain: domain
    end

    private

    def set_domain
        self.domain = current_recruiter.email.split('@').last
    end
end
