class CreateCouncils < ActiveRecord::Migration[5.1]
  def change
    create_table :councils do |t|
      t.string :name
      t.string :shortcut
      t.string :color

      t.timestamps
    end
  end
end
