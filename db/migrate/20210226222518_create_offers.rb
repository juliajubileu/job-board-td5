class CreateOffers < ActiveRecord::Migration[6.1]
  def change
    create_table :offers do |t|
      t.integer :salary
      t.date :starting_date
      t.text :message
      t.references :application, null: false, foreign_key: true

      t.timestamps
    end
  end
end
