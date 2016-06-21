class ManagerController < ApplicationController
  def register
    if User.find_by(user_id: params[:userId]).nil?
      @user = User.create!(user_id: params[:userId], password: params[:password], first_name: params[:firstName], last_name:params[:lastName], address: params[:address], city: params[:city], state: params[:state], postal_code: params[:postalCode], country: params[:country], email: params[:email])
      createPhone('Cell', params[:cellPhone])
      createPhone('Work', params[:workPhone])
      createPhone('Home', params[:homePhone])
      render 'register.html.erb'
    else
      flash[:notice] = 'User ID taken, try another'
      render '/landing/land.html.erb'
    end
  end
  def createPhone(type, number)
    if !number.strip.blank?
      @user.phones << Phone.create!(phone_type: type, phone_number: number)
    end
  end
end
