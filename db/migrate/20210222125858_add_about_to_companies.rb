class AddAboutToCompanies < ActiveRecord::Migration[6.1]
  def change
    add_column :companies, :about, :text
  end
end
