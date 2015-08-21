class GeneralMailer < ApplicationMailer

  def test_email
    mail(to: 'jamie@email.com', subject: 'This is a test')
  end

end
