require 'rails_helper'

RSpec.describe Company, type: :model do
    describe 'associations' do
        it { should have_one_attached(:logo) }
        it { should have_many(:recruiters).class_name('Recruiter') } 
        it { should have_many(:jobs).class_name('Job') }
    end
      
    describe 'validations' do
        it { should validate_presence_of(:name) }
        it { should validate_presence_of(:address) }
        it { should validate_presence_of(:cnpj) }
        it { should validate_presence_of(:domain) }
        it { should validate_presence_of(:website) }

        it { should validate_uniqueness_of(:name) }
        it { should validate_uniqueness_of(:cnpj) }
        it { should validate_uniqueness_of(:domain) }
    end
end