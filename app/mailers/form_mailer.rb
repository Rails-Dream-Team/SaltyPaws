class FormMailer < ActionMailer::Base
  default from: "Form Submit <noreply@saltypaws.com>"
  default to: "Admin <saltypaws@gmx.us>"

  def new_vol_form(volunteer)
    @volunteer = volunteer
    mail subject: "New Volunteer form from #{volunteer.first_name}  #{volunteer.last_name}"
  end

  def report_colony_form(report)
    @report = report
    mail subject: "New potential colony report from #{report.first_name} #{report.last_name}"
  end
  
end
