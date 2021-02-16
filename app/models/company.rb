class Company < ApplicationRecord
    has_one_attached :logo

    validates :name, :cnpj, presence: true, uniqueness: true

    def find_by_domain(domain)
        Company.find_by domain: domain
    end
end
