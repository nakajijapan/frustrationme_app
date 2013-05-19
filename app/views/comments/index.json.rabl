collection @comments, object_root: false
attributes(:id, :user_id, :item_id, :text, :created_at, :udated_at)

child(:user) {
  attributes(:id, :username, :icon_name, :created_at, :udated_at)
}