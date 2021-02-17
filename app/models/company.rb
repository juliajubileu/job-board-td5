class Company < ApplicationRecord
    has_one_attached :logo
    
    validates :name, :address, :cnpj, :domain, :website, presence: true
    validates :name, :cnpj, :domain, uniqueness: true

    def find_by_domain(domain)
        Company.find_by domain: domain
    end
end
