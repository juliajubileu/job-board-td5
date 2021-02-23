require 'rails_helper'

RSpec.describe Job, type: :model do
    describe 'associations' do
        it { should belong_to(:company).class_name('Company') }
     # have_many candidates through application
    end
      
    describe 'validations' do
        it { should validate_presence_of(:title, :description, :remuneration, :level, 
                                         :requirements, :expiration_date, :spots_available) }
    end

    describe 'valid?' do
        context 'remuneration' do
            it 'should be higher than minimum wage' do

            end
        end

        context 'expiration date' do
            it 'should be in the future' do

            end
        end

        context 'spots available' do
            it 'should be positive' do
                
            end
        end
    end
end