class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.text :email
      t.text :first_name
      t.text :last_name
      t.text :user
      t.text :status
      t.string :role
      t.string :password_digest

      t.timestamps
    end
  end
end
