class RemoveClinicFromPatients < ActiveRecord::Migration[6.1]
  def change
    remove_column :patients, :clinic, :integer
  end
end
