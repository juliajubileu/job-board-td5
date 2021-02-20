class CreateJobs < ActiveRecord::Migration[6.1]
  def change
    create_table :jobs do |t|
      t.string :title
      t.text :description
      t.decimal :remuneration
      t.string :level
      t.string :requirements
      t.date :expiration_date
      t.integer :spots_available
      t.references :company, null: false, foreign_key: true

      t.timestamps
    end
  end
end
