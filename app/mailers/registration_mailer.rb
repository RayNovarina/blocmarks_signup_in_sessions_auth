#
class RegistrationMailer < ApplicationMailer
  default from: 'RNova94037@Gmail.com'

  def sign_up_confirmation(user)
    headers['Message-ID'] = '<sign-up/#{user.id}@blocmarks.example>'
    headers['In-Reply-To'] = "<conf/#{user.id}@blocmarks.example>"
    headers['References'] = "<conf/#{user.id}@blocmarks.example>"

    @user = user

    mail(to: user.email, subject: 'Confirming your new account at Blocmarks')
  end
end
