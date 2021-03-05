class RenameJobApplicationsInOffers < ActiveRecord::Migration[6.1]
  def change
    rename_column :offers, :application_id, :job_application_id
  end
end
