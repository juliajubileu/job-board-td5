class AddFieldsToCandidates < ActiveRecord::Migration[6.1]
  def change
    add_column :candidates, :full_name, :string
    add_column :candidates, :social_name, :string
    add_column :candidates, :cpf, :string
    add_column :candidates, :phone, :string
    add_column :candidates, :bio, :text
  end
end
