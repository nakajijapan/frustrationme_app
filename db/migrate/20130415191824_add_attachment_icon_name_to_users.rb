class AddAttachmentIconNameToUsers < ActiveRecord::Migration
  def self.up
    change_table :users do |t|
      t.attachment :icon_name
    end
  end

  def self.down
    drop_attached_file :users, :icon_name
  end
end
