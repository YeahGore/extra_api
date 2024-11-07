class RenameColumnFromTable < ActiveRecord::Migration[7.1]

  def change 
    change_table :links do |t|
      t.rename :body, :source
    end
  end
end
