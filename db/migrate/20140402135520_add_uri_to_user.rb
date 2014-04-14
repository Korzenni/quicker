class AddUriToUser < ActiveRecord::Migration
  def change
  	add_column :users, :uri, :string
    add_index  :users, :uri
  end
end
