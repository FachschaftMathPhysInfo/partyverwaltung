class CreateJudges < ActiveRecord::Migration[5.1]
  def change
    create_table :judges do |t|
      t.string :controller
      t.string :method
      t.integer :level

      t.timestamps
    end
  end
end
