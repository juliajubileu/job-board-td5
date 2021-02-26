class Application < ApplicationRecord
  belongs_to :job
  belongs_to :candidate
  has_one :rejection

  enum status: { pending: 0, approved: 5, rejected: 10 } 
end
