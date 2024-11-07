class AddReferences < ActiveRecord::Migration[7.1]

  def change
    add_reference :links, :user, foreign_key: true
    add_reference :users, :team, foreign_key: true
  end
end
