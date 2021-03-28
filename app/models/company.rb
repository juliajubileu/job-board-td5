class Company < ApplicationRecord
  has_one_attached :logo
  has_many :recruiters, dependent: :destroy
  has_many :jobs, dependent: :destroy

  validates :domain, presence: true, uniqueness: true
  validates :name, :address, :cnpj, :website, :about, presence: true,
                                                      on: :update
  validates :name, :cnpj, :website, uniqueness: true, on: :update
end
