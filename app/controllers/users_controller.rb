#
class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    if new_user_submission_valid?
      @user.save!
      flash[:notice] = "Welcome to Blocmarks #{@user.name}!"
      create_session(@user)
      redirect_to root_path
    end
    # Note: else we have already been redirected to error handler.
  end

  private

  # Create new User object @user from submitted params. Validate and handle
  # errors cases.
  def new_user_submission_valid?
    @user = User.new
    @user.name = params[:user][:name]
    @user.email = params[:user][:email]
    @user.password = params[:user][:password]
    @user.password_confirmation = params[:user][:password_confirmation]

    if !@user.valid?
      flash.now[:alert] = 'There was an error creating your account. Please try again.'
      render :new
      return false
    end
    return true
  end
end
