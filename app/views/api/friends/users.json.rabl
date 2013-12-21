collection @users
attribute :id, :username, :icon_name, :following_id

node(:followed, if: lambda { |m| @current_friends.present? && @current_friends.index(m.following_id).present? }) do |user|
  true
end
