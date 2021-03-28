class AddUniquenessToCompany < ActiveRecord::Migration[6.1]
  def change
    add_index(:companies, :domain, unique: true)
    add_index(:companies, :name, unique: true)
    add_index(:companies, :cnpj, unique: true)
    add_index(:companies, :website, unique: true)
  end
end
