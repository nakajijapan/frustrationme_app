require 'spec_helper'

describe Friendship do

  context 'when user following others' do
    before do
      @u        = create(:user_nakaji)
      @u_target = create(:user_hamaji)
      @f = Friendship.new({user_id: @u.id, following_id: @u_target.id})
    end

    it 'can save' do
      @f.save
    end

    it 'can unfollow' do
      @f.save
      expect(@f.following_user.username).to eq @u_target.username
    end

  end
end
