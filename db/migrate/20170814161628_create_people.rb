class CreatePeople < ActiveRecord::Migration[5.1]
  def change
    create_table :people do |t|
      t.string :vname
      t.string :nname
      t.string :mail
      t.string :shirt
      t.string :typ
      t.integer :wert

      t.timestamps
    end
  end
end
