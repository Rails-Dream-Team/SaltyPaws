class VolunteersController < ApplicationController

  def new
    @volunteer = Volunteer.new
  end

  def create
    @volunteer = Volunteer.new(volunteer_params)
    if @volunteer.valid?
      GeneralMailer.volunteer_submission(@volunteer).deliver_now
      FormMailer.new_vol_form(@volunteer).deliver_now
      redirect_to root_path, notice: "Your form was submitted."
    else
      flash[:alert] = "An error occurred while submitting your form."
      render :new
    end
  end

  private

  def volunteer_params
    params.require(:volunteer).permit(:first_name, :last_name, :email, :phone, :age,  :adoption_events, :transportation, :assist_with_trapping, :colony_caregiver, :substitute_colony_caregiver, :skills, :weekends, :weekdays, :evenings, :daytime, :flexible)
  end
end
