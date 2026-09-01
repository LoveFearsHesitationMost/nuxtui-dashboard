class AddProfileFieldsToUsers < ActiveRecord::Migration[8.1]
  def change
    add_column :users, :name, :string, null: false, default: ""
    add_column :users, :bio, :text
    add_column :users, :private_email, :boolean, null: false, default: false
  end
end
