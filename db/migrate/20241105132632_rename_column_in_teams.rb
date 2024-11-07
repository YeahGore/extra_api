class RenameColumnInTeams < ActiveRecord::Migration[7.1]

  def change
    change_table :teams do |t|
      t.rename :type, :teamtype
    end
  end
end
