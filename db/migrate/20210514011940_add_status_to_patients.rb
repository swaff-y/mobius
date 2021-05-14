class AddStatusToPatients < ActiveRecord::Migration[6.1]
  def change
    add_column :patients, :status, :text
  end
end
