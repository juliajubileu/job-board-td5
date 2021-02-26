class CreateRejections < ActiveRecord::Migration[6.1]
  def change
    create_table :rejections do |t|
      t.text :motive
      t.references :application, null: false, foreign_key: true

      t.timestamps
    end
  end
end
