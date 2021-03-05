class RenameJobApplicationsInRejections < ActiveRecord::Migration[6.1]
  def change
    rename_column :rejections, :application_id, :job_application_id
  end
end
