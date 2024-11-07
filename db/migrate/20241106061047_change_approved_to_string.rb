class ChangeApprovedToString < ActiveRecord::Migration[7.1]

  def change
    change_column :links, :approved, :string
  end

end
