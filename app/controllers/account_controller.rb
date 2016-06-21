class AccountController < ApplicationController
  def login
    @user = User.find_by(user_id: params[:logUserId])
    if @user.password == params[:logPassword]
      render 'login.html.erb'
    else
      flash[:notice] = 'Invalid login credentials'
      render '/landing/land.html.erb'
    end
  end
end
