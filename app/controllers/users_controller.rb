class UsersController < ApplicationController
  before_action :set_user, only: [:destroy]

  def create
    @user = User.new(user_params)
    @user.token = SecureRandom.hex

    if @user.save
      render :show, status: :created
    else
      render json: @user.errors, status: :unprocessable_entity 
    end
  end

  def login
    @user = User.find_by username: params['username']

    if @user and @user.authenticate params['password']
      render :login
    else
      render json: { error: "Unauthorized" }, status: :unauthorized
    end
  end

  private
    def user_params
      user_pars = params.require(:user).permit(:username, :token, :name, :password, :password_confirmation)
      user_pars['password'] = params['password']
      user_pars['password_confirmation'] = params['password_confirmation']
      user_pars
    end
end
