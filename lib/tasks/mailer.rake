namespace :mailer do
  desc 'Test email'
  task test_email: :environment do
    GeneralMailer.test_email.deliver_now
  end
end
