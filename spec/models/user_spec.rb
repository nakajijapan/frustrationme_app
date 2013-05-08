require 'spec_helper'

describe User do

  context 'when validates attributes' do
    before do
      @u = create(:user_nakaji)
    end

    describe '@username' do

      it 'is invalid require' do
        @u.username = nil
        @u.should_not be_valid
      end

      it 'is invalid length, too short.' do
        @u.username = "hog"
        @u.should_not be_valid
      end

      it 'is invalid length, too long.' do
        @u.username = "hogehogehogehoge3"
        @u.should_not be_valid
      end

      it 'is invalid format' do
        @u.username = '!{432?_'
        @u.should_not be_valid
      end

      it 'is valid' do
        @u.username = "nakajijapan"
        @u.should be_valid
      end
    end

    describe '@password' do

      it 'is invalid require' do
        @u.password = nil
        @u.should_not be_valid
      end

      it 'is invalid length, too short.' do
        @u.password = "hog"
        @u.should_not be_valid
      end

      it 'is invalid length, too long.' do
        @u.password = "hogehogehogehoge3"
        @u.should_not be_valid
      end

      it 'is invalid format' do
        @u.password = '!{432?_'
        @u.should_not be_valid
      end

      it 'is valid' do
        @u.password = "password"
        @u.should be_valid
      end
    end

    describe '@email' do
      it 'is invalid require' do
        @u.email = nil
        @u.should_not be_valid
      end

      it 'is invalid format' do
        @u.email = '!{432?_'
        @u.should_not be_valid
      end

      it 'is valid' do
        @u.email = "test@mojide.com"
        @u.should be_valid
      end
    end

    describe '@sex' do
      it 'is invalid format' do
        @u.sex = 4
        @u.should_not be_valid
      end

      it 'is invalid string format' do
        @u.sex = '1'
        @u.should be_valid
      end

      it 'is valid' do
        @u.sex = 2
        @u.should be_valid
      end
    end
  end

  context 'when user is a valid data' do
    it 'can save' do
      u = User.new(username: 'nakajijapan', password: 'nahanaha', password_confirmation: 'nahanaha', email: 'hogehoge@hoge.com')
      u.save!.should be_true
    end

    it 'can create with omniauth' do
      auth = {'provider' => 'twitter', 'uid' => 1234567890, 'info' => {'nickname' => 'hogejapan'}}
      u = User.create_with_omniauth(auth)
      u.class.should == User
    end
  end

  context 'when user following others' do
    before do
      @u        = create(:user_nakaji)
      @u_target = create(:user_hamaji)
      Friendship.new({user_id: @u.id, following_id: @u_target.id}).save
    end

    it 'can unfollow' do
      @u.unfollow(@u_target.id).should be > 0
    end

    it 'has following' do
      @u.following_ids([@u_target.id]).should have(1).items
    end
  end

  context 'when user delete fuman' do
    before do
      @u = create(:user_nakaji)
      @i = create(:item_amazon)
      @f = create(:fuman, user_id: @u.id, item_id: @i.id)
      @c = create(:comment, user_id: @u.id, item_id: @i.id, text: 'hogehoge')

      @u.delete_fuman(@f.id)
    end

    it 'can delete fuman' do
      expect(Fuman.where(:id, @f.id)).to be_empty
    end

    it 'can delete comment' do
      expect(Comment.where(:item_id, @f.item_id)).to be_empty
    end
  end

end
