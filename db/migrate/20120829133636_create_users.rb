class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :username,         :null => false
      t.string :crypted_password, :null => false
      t.string :icon_name
      t.string :email, :null => false
      t.integer :sex
      t.datetime :birthday
      t.integer :pref
      t.text :message
      t.string :twitter_id
      t.text :twitter_token
      t.integer :twitter_notice
      t.string :facebook_id
      t.text :facebook_token
      t.integer :facebook_notice

      t.timestamps
    end
  end
end
