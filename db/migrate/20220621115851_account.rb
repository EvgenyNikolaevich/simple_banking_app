class Account < ActiveRecord::Migration[7.0]
  def change
    create_table :accounts do |t|
      t.belongs_to :user, null:false, index: true, foreign_key: true
      t.bigint :balance, null: false, default: 0

      t.timestamps
    end

    execute('ALTER TABLE accounts ADD CONSTRAINT balance CHECK (balance >= 0);')
  end
end
