class Company < ApplicationRecord
    validates :name, presence: true
    validates :cnpj, presence: true, uniqueness: true
end
