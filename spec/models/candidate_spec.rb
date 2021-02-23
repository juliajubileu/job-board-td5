require 'rails_helper'

RSpec.describe Candidate, type: :model do
  describe 'associations' do
    # have_many jobs through application
  end
  
  describe 'validations' do
      it { should validate_presence_of(:full_name, :cpf, :bio, :email) }
      it { should validate_uniqueness_of(:cpf, :email) }
  end
end