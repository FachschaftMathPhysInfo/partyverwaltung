class ChangeEmailColumnName < ActiveRecord::Migration[5.1]
  def change
    rename_column :emails, :sentcode, :sendcode
  end
end
