class UsersController < ApplicationController
  def index
    @users = User.all
    @user = User.find(session[:user_id]) rescue nil
  end

  def new
    @user = User.new
  end

  def create

  end

  def show

  end

  def login_form

  end

  def login

  end

  def logout
    session[:user_id] = nil
    redirect_to root_path
  end
end
