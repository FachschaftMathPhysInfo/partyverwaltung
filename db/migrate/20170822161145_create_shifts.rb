class CreateShifts < ActiveRecord::Migration[5.1]
  def change
    create_table :shifts do |t|
      t.time :start
      t.time :ende
      t.integer :person_id
      t.integer :section_id
      t.integer :council_id

      t.timestamps
    end
  end
end
