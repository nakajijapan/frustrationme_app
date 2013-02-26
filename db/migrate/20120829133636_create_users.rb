class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string    :username,       :null => false
      t.string    :crypted_password
      t.string    :icon_name,     :limit => 1024
      t.string    :email
      t.integer   :sex
      t.datetime  :birthday
      t.text      :message

      t.string  :twitter_use
      t.integer :facebook_use

      t.string :provider
      t.string :uid

      t.timestamps
    end
  end
end
