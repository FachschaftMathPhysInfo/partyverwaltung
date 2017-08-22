class CreateBugs < ActiveRecord::Migration[5.1]
  def change
    create_table :bugs do |t|
      t.string :name
      t.text :text
      t.integer :typ
      t.integer :value

      t.timestamps
    end
  end
end
