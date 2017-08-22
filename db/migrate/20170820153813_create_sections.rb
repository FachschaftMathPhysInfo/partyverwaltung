class CreateSections < ActiveRecord::Migration[5.1]
  def change
    create_table :sections do |t|
      t.string :name
      t.text :text
      t.boolean :visible
      t.integer :party_id

      t.timestamps
    end
  end
end
