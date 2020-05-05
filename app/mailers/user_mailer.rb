# frozen_string_literal: true

class UserMailer < ActionMailer::Base
  default from: 'anish99033@gmail.com'

  def registration_confirmation(user)
    @user = user
    mail(to: "#{@user.name} <#{@user.email}>", subject: 'Registration Confirmation')
  end
end
