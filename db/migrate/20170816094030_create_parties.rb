class CreateParties < ActiveRecord::Migration[5.1]
  def change
    create_table :parties do |t|
      t.integer :jahr
      t.string :semester
      t.boolean :active

      t.timestamps
    end
  end
end
