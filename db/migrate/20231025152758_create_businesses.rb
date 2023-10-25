class CreateBusinesses < ActiveRecord::Migration[7.0]
  def change
    create_table :businesses do |t|
      t.string :uuid
      t.jsonb :listing, null: false, default: {}
      t.datetime :expires_at

      t.timestamps
    end
    add_index :businesses, :uuid, unique: true
  end
end
