class ReportsController < ApplicationController

  def new
    @report = Report.new
  end

  def create
    @report = Report.new(report_params)
    if @report.valid?
      FormMailer.report_colony_form(@report).deliver_now
      redirect_to root_path, notice: "Your form was submitted."
    else
      flash[:alert] = "An error occurred while submitting your form."
      render :new
    end
  end

  private

  def report_params
    params.require(:report).permit(:first_name, :last_name, :email, :phone, :street_address, :city, :state, :zip_code, :location, :pop, :fixed, :young, :current_caretaker)
  end
end
