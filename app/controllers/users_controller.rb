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
    user = find_user(params[:username])
    if user.present?
      enc = JWT.decode user.password_digest, user.password_salt, false, { algorithm: 'HS256' }
      if params[:password_digest] == enc[0]
        render :json => {
          :username => user.username,
          :name => user.name,
          :mail => user.email,
          :ph_no => user.mobile,
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

  def reset_password
    user = find_user(params[:id])
    digest = JWT.encode params[:password_digest], params[:token], 'HS256'
    if user.update({:password_digest => digest, :password_salt => params[:token]})
      render :json => {
        :msg => "Password Changes"
      }
    end
  end

  def generate_reset_token
    user = find_user(params[:id])
    token = BCrypt::Engine.generate_salt
    if user.present?
      if user.update_column(:reset_token, token)
        render :json => {
          :token => token
        },
        :status => 200
      end
    else
      render :json => {
        :msg => "Username Or Email Not Found"
      }
    end
  end


  private
  def user_params
    params.require(:user).permit(:username, :password_digest, :name, :email, :mobile)
  end

  def find_user(user_id)
    return User.find_by_username(user_id) || User.find_by_email(user_id)
  end
end
