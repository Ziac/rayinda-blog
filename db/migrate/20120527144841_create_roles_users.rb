class CreateRolesUsers < ActiveRecord::Migration
  def change
    create_table :roles_users do |t|
      t.belongs_to :user
      t.belongs_to :role

      t.timestamps
    end
    add_index :roles_users, :user_id
    add_index :roles_users, :role_id
  end
end
