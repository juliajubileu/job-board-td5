require 'rails_helper'

RSpec.describe Recruiter, type: :model do
  describe 'associations' do
    it { should belong_to(:company).class_name('Company') } 
  end
  
  describe 'validations' do
    it { should validate_presence_of(:email) }
  end

  # roles admin/member - Ainda não implementado
  # email cant be personal - Definindo se método vai permanecer no model
end