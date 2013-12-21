collection @users, root: :users, object_root: false
attribute :id, :username, :icon_name, :following_id

node(:followed, if: lambda { |m| @current_friends.present? && @current_friends.index(m.user_id).present? }) do |user|
  true
end

