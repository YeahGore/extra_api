class AddEnumAttrs < ActiveRecord::Migration[7.1]

  def change

      add_column :links, :approve, :integer, default: 0
      add_column :links, :reason, :integer, default: 0
      add_column :users, :role, :integer, default: 0
      add_column :teams, :team_type, :integer, default: 0
  end

end
