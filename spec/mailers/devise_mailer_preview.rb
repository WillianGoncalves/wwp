# https://github.com/plataformatec/devise/wiki/How-To:-Use-custom-mailer
class Devise::MailerPreview < ActionMailer::Preview
  def confirmation_instructions
    Devise::Mailer.confirmation_instructions(User.first, 'faketoken', {})
  end
end
