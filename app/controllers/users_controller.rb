class UsersController < ApplicationController

  def show
    @user = current_user
    respond_to do |format|
      format.html
      format.json { render json: @user }
    end
  end

  def edit
    @user = get_user
  end

  def update
    @user = get_user
    respond_to do |format|
      if @user.update_attributes(user_params)
        format.html { redirect_to user_path(@user) }
        format.json { render json: @user, status: 202 }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: 422 }
      end
    end
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :display_name, :email, :street_address, :city, :state, :zip, :phone, :age, :twitter, :facebook, :instagram, :about_me, :pets, :volunteer_work)
  end

  def get_user
    User.find(params[:id])
  end

end
