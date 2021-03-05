class RenameApplicationsToJobApplications < ActiveRecord::Migration[6.1]
  def change
    rename_table :applications, :job_applications
  end
end
