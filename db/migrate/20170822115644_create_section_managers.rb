class CreateSectionManagers < ActiveRecord::Migration[5.1]
  def change
    create_table :section_managers do |t|
      t.integer :section_id
      t.integer :person_id

      t.timestamps
    end
  end
end
