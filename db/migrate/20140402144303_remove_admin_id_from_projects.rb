class RemoveAdminIdFromProjects < ActiveRecord::Migration
  def change
  	remove_column :projects, :admin_id
  	add_column :projects, :admin_name, :string
  	add_column :projects, :admin_email, :string
  	add_column :projects, :admin_uri, :string
  end
end
