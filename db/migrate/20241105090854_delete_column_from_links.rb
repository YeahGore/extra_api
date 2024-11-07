class DeleteColumnFromLinks < ActiveRecord::Migration[7.1]

  def change
    
    change_table :links do |t|
      t.remove :user_id
    end
  end
end
