class AddRoleToRecruiters < ActiveRecord::Migration[6.1]
  def change
    add_column :recruiters, :role, :integer
  end
end
