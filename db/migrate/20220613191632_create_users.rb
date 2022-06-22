class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :login
      t.string :password_hash

      t.timestamps
    end

      add_index :users, :login, unique: true
  end
end
