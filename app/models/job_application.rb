class JobApplication < ApplicationRecord
  belongs_to :job
  belongs_to :candidate
  has_one :rejection, dependent: :destroy
  has_one :offer, dependent: :destroy

  enum status: { pending: 0, approved: 5, rejected: 10 }
end
