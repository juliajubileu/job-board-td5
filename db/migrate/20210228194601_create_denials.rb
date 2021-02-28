class CreateDenials < ActiveRecord::Migration[6.1]
  def change
    create_table :denials do |t|
      t.text :motive
      t.references :offer, null: false, foreign_key: true

      t.timestamps
    end
  end
end
