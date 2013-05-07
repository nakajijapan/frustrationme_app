# coding: utf-8
class UserMailer < ActionMailer::Base
  default from: 'noreply@gmail.com'

  def regist(user)
    mail to: user.email, subject: '[frustration.me] ユーザ登録のお知らせ。'
  end
end
