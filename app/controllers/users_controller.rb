class UsersController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    user = User.new(user_params)
    if user.save
      render :json => {
        :msg => "successfully saved",
        :success => true
      },
      :status => 200
    end
  end

  def login
    user = User.find_by_username(params[:username]) || User.find_by_email(params[:username])
    if user.present?
      enc = JWT.decode user.password_digest, user.password_salt, false, { algorithm: 'HS256' }
      if params[:password_digest] == enc[0]
        render :json => {
          :username => user.username,
          :token => BCrypt::Engine.generate_salt,
          :success => true
        },
        :status => 200
      else
        render :json => {
          :msg => "Username Or Password Is INVALID",
          :success => false
        }
      end
    else
      render :json => {
        :msg => "User Not Found Please Sign Up",
        :success => false,
        :path => "/sign-up"
      }
    end
  end


  private
  def user_params
    params.require(:user).permit(:username, :password_digest, :name, :email, :mobile)
  end
end
