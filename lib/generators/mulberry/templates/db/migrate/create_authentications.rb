class CreateAuthentications < ActiveRecord::Migration
  def change
    create_table :authentications do |t|
      t.belongs_to :user, index: true
      t.string :uid
      t.string :provider
      t.string :access_token

      t.timestamps
    end
    
    add_index :authentications, [:uid, :provider], :unique => true
  end
end
