class CreateStatuses < ActiveRecord::Migration[5.1]
  def change
    create_table :statuses do |t|
      t.integer :person_id
      t.integer :value

      t.timestamps
    end
  end
end
