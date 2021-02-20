class AddCompanyToRecruiter < ActiveRecord::Migration[6.1]
  def change
    add_reference :recruiters, :company, null: false, foreign_key: true
  end
end
