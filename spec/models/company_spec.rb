require 'rails_helper'

RSpec.describe Company, type: :model do
    describe 'associations' do
        it { should have_one_attached(:logo) }
        it { should have_many(:recruiters).class_name('Recruiter') } 
        it { should have_many(:jobs).class_name('Job') }
    end
      
    describe 'validations' do
        it { should validate_presence_of(:name, :address, :cnpj, :domain, :website) }
        it { should validate_uniqueness_of(:name, :cnpj, :domain) }
    end

    describe 'valid?' do
        context 'find by domain' do

        end
    end
end