class GeneralMailer < ApplicationMailer

  def volunteer_submission(volunteer)
    @volunteer = volunteer
    mail(to: volunteer.email, subject: 'Thank you for wanting to volunteer.')
  end

  def colony_reported(report)
    @report = report
    mail(to: report.email, subject: 'Thank you for reporting this colony.')
  end

end
