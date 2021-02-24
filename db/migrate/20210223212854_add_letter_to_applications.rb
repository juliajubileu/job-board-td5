class AddLetterToApplications < ActiveRecord::Migration[6.1]
  def change
    add_column :applications, :letter, :text
  end
end
