class CreateShirts < ActiveRecord::Migration[5.1]
  def change
    create_table :shirts do |t|
      t.integer :jahr
      t.string :semester
      t.text :motto
      t.attachment :photo

      t.timestamps
    end
  end
end
