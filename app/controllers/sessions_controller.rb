class SessionsController < ApplicationController

  skip_before_action :require_login, only: [:new, :create]

  def new
  end

  def create
    user = User.find_by(name: params[:session][:name])
    if user && user.authenticate(params[:session][:password])
      # Log the user in and redirect to the user's show page.
      log_in user
      redirect_to root_path
    else
      # Create an error message.
      flash.now[:danger] = 'Invalid login'
      render 'new'
    end
  end

  def destroy
    session.delete(:user_id)
    @current_user = nil

    redirect_to login_path
  end
end
