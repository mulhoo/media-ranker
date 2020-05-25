class WorksController < ApplicationController
  def index
    @works = Work.all 
    @user = User.find(session[:user_id]) rescue nil
  end

  def show

  end

  def new
    @work = Work.new
  end

  def create

  end

  def update

  end

  def destroy

  end



  private

  def work_params
    return params.require(:work).permit(:title, :creator, :category, :publication_year, :description)
  end
end
