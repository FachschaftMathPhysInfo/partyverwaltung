class CreateEmails < ActiveRecord::Migration[5.1]
  def change
    create_table :emails do |t|
      t.string :name
      t.string :subject
      t.text :content
      t.string :sentcode

      t.timestamps
    end
  end
end
