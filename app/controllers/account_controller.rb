class AccountController < ApplicationController
  def login
    @user = User.find_by(user_id: params[:logUserId])
    if @user.password == params[:logPassword]
      session[:user_id] = @user.id
      render 'login.html.erb'
    else
      flash[:notice] = 'Invalid login credentials'
      render '/landing/land.html.erb'
    end
  end

  def logout
    session[:user_id] = nil
    flash[:notice] = 'You have logged out successfully'
    render '/landing/land.html.erb'
  end
end
