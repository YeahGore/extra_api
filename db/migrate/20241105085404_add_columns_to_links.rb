class AddColumnsToLinks < ActiveRecord::Migration[7.1]

  def change
    add_column :links, :rec_time, :time
    add_column :links, :time_moment_in_call, :time
    add_column :links, :reason, :string 
    add_column :links, :description, :string
  end
end
