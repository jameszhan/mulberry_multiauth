class AddFieldsToUsers < ActiveRecord::Migration
  def change
    add_column  :users,   :name,  :string    
    add_index   :users,   :name,  :unique => true

    add_column :users, :login_type, :string, default: 'password'
    
    add_column :users, :avatar, :string
    add_column :users, :crop_x, :integer
    add_column :users, :crop_y, :integer
    add_column :users, :crop_w, :integer
    add_column :users, :crop_h, :integer    
  end
end
