class CreateAccounts < ActiveRecord::Migration[7.0]
  def change
    create_table :accounts do |t|
      t.string :name
      t.string :token

      t.timestamps
    end
    add_index :accounts, :name, unique: true
    add_index :accounts, :token, unique: true
  end
end
