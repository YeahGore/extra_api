class DeleteStringAttrs < ActiveRecord::Migration[7.1]

  def change

    change_table :links do |t|
      t.remove :approve
      t.remove :reason
    end

    change_table :users do |t|
      t.remove :role
    end

    change_table :teams do |t|
      t.remove :teamtype
    end
  end

end
