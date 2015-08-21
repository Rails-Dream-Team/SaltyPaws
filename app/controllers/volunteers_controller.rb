class VolunteersController < ApplicationController

  def new
    @volunteer = Volunteer.new
  end

  def create
    @volunteer = Volunteer.new(volunteer_params)
    if @volunteer.valid?
      FormMailer.new_vol_form(@volunteer).deliver
      redirect_to volunteer_path, notice: "Your form was submitted."
    else
      flash[:alert] = "An error occurred while submitting your form."
      render :new
    end
  end

  private

  def volunteer_params
    params.require(:volunteer).permit(:first_name, :last_name, :email, :phone,
    :age, :vol_areas, :skills, :availability)
  end
end
