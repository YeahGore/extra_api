class CreateUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :users do |t|
      t.integer :chatwoot_id
      t.string :chatwoot_name
      t.string :role

      t.timestamps
    end
  end
end
