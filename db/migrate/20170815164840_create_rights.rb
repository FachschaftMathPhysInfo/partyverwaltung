class CreateRights < ActiveRecord::Migration[5.1]
  def change
    create_table :rights do |t|
      t.string :nick
      t.integer :level

      t.timestamps
    end
  end
end
