node :target_user do
  { id: @target_user.id, username: @target_user.username }
end

node :users do
  partial('api/friends/users', object: @users)
end

node :pager do
  { current: 1, next: false, back: false }
end