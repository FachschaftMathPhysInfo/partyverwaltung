class CreateNotes < ActiveRecord::Migration[5.1]
  def change
    create_table :notes do |t|
      t.integer :wertung
      t.text :text
      t.integer :person_id
      t.integer :party_id
      t.string :author

      t.timestamps
    end
  end
end
