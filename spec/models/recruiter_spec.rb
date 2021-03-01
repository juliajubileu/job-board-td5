require 'rails_helper'

RSpec.describe Recruiter, type: :model do
  describe 'associations' do
    it { should belong_to(:company).class_name('Company') } 
  end
  
  describe 'validations' do
    it { should validate_presence_of(:email) }

    it 'should not be valid with personal email' do
        # Definindo se método estará no model ou no controller
    end
  end

  # roles admin/member - Ainda não implementado
end