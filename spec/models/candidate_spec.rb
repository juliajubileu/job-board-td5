require 'rails_helper'

RSpec.describe Candidate, type: :model do
  describe 'associations' do
    # have_many jobs through application
  end
  
  describe 'validations' do
      it { should validate_presence_of(:full_name) }
      it { should validate_presence_of(:cpf) }
      it { should validate_presence_of(:bio) }
      it { should validate_presence_of(:email) }

      it { should validate_uniqueness_of(:cpf) }
      it { should validate_uniqueness_of(:email).case_insensitive }
  end
end