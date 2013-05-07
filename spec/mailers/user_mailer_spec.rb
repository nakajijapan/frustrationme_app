# coding: utf-8
require "spec_helper"

describe UserMailer do

  describe "regist" do
    let(:mail) {
      u = create(:user_nakaji)
      UserMailer.regist(u)
    }

    it "renders the headers" do
      expect(mail.subject).to eq '[frustration.me] ユーザ登録のお知らせ。'
      expect(mail.to).to      eq ["hogehoge@majide.com"]
      expect(mail.from).to    eq ["noreply@gmail.com"]
    end

    it "renders the body" do
      expect(mail.body.encoded).to match "welcome to frustration.me"
    end
  end

end
