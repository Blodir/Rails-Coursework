class SessionsController < ApplicationController
  def create_oauth
    user = User.find_by username: env["omniauth.auth"].info.nickname

    if user.nil?
      user = User.create
      user.username = env["omniauth.auth"].info.nickname
      user.password = user.password_confirmation = SecureRandom.urlsafe_base64(n=6)
      user.admin = false
      user.save
      session[:user_id] = user.id
      redirect_to user_path(user), notice: "welcome"
    elsif user && !user.iced
      session[:user_id] = user.id
      redirect_to user_path(user), notice: "welcome back"
    elsif user.iced
      redirect_to :back, notice: 'this account is frozen'
    end
  end

  def new
  end

  def create
    user = User.find_by username: params[:username]
    if user && user.authenticate(params[:password])
      if user.locked?
        redirect_to :back, notice: "Your account is frozen, please contact admin"
      else
        session[:user_id] = user.id
        redirect_to user_path(user), notice: "Welcome back!"
      end
    else
      redirect_to :back, notice: "Username and/or password mismatch"
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to :root
  end
end
