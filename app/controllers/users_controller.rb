class UsersController < ApplicationController
  def index
    @users = User.all
    @user = User.find(session[:user_id]) rescue nil
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      @user[:date_joined] = Date.today
      redirect_to user_path(@user.id)
      return
    else
      render :new
      return
    end
  end

  def show
    @user = User.find_by(id: params[:id])
    
    if @user.nil?
      head :not_found
      return
    end
  end

  def current_user
    @current_user = User.find_by(id: session[:user_id])

    unless @current_user
      flash[:warning] = "Please log in to see this page."
      redirect_to root_path
      return
    end
  end

  def login_form
    @user = User.new
  end

  def login
    name = params[:user][:name]
    user = User.find_by(name: name)

    if user
      session[:user_id] = user.id
      flash[:success] = "Logged in as #{name}"
    else
      user = User.create(name: name)
      session[:user_id] = user.id
      flash[:success] = "Logged in as new user #{name}"
    end
    
    redirect_to root_path
  end

  def logout
    session[:user_id] = nil
    redirect_to root_path
    return
  end

  private

  def work_params
    return params.require(:user).permit(:name)
  end
end
