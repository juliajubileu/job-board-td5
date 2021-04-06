require 'rails_helper'

RSpec.describe Job, type: :model do
  before do
    allow(Time.zone).to receive(:today).and_return Time.new(2021, 2, 3)
  end

  describe 'status' do
    it 'default is enabled' do
      # Arrange
      company = create(:company)
      job = create(:job, company: company)

      # Assert
      expect(job).to be_enabled
    end

    it 'automatically disabled when all spots are filled' do
      # Arrange
      company = create(:company)
      job = create(:job, company: company, spots_available: 1, status: :enabled)
      candidate = create(:candidate)
      application = JobApplication.create!(job: job, candidate: candidate,
                                           status: :approved)
      create(:offer, job_application: application, status: :accepted)

      # Act
      job.reload

      # Assert
      expect(job).to be_disabled
    end
  end
end
