class GeneralMailer < ApplicationMailer

  def test_email
    mail(to: 'fromraintohope@gmail.com', subject: 'This is a test')
  end

end
