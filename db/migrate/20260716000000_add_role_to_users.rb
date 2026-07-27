class AddRoleToUsers < ActiveRecord::Migration[8.1]
  def up
    add_column :users, :role, :string, null: false, default: "content_manager"
    # Everyone who could sign in before roles existed had full access.
    execute "UPDATE users SET role = 'admin'"
  end

  def down
    remove_column :users, :role
  end
end
