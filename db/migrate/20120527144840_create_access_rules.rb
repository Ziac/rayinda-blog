class CreateAccessRules < ActiveRecord::Migration
  def change
    create_table :access_rules do |t|
      t.belongs_to :permission
      t.belongs_to :role
      t.integer :role_type, :default => 0
    end
    add_index :access_rules, :permission_id
    add_index :access_rules, :role_id
  end
end
