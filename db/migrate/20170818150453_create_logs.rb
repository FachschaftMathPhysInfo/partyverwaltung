class CreateLogs < ActiveRecord::Migration[5.1]
  def change
    create_table :logs do |t|
      t.string :controller
      t.string :method
      t.string :user

      t.timestamps
    end
  end
end
