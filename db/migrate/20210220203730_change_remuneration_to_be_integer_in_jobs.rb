class ChangeRemunerationToBeIntegerInJobs < ActiveRecord::Migration[6.1]
  def up
    change_column :jobs, :remuneration, :integer
  end
  def down
    change_column :jobs, :remuneration, :decimal
  end
end
