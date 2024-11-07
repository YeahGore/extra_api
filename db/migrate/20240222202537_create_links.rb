class CreateLinks < ActiveRecord::Migration[7.1]
  def change
    create_table :links do |t|
      t.string :body
      t.integer :user_id
      t.string :comment
      t.boolean :approved

      t.timestamps
    end
  end
end
