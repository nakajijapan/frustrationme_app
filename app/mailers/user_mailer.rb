# coding: utf-8
class UserMailer < ActionMailer::Base
  default from: 'noreply@gmail.com'

  def regist(user)
    mail to: user.email, subject: '[frustration.me] ユーザ登録のお知らせ。'
  end

  def reset_password(user)
    @user = user
    mail to: user.email, subject: '[frustration.me] パスワード再設定'
  end
end
