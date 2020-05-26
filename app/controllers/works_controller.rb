class WorksController < ApplicationController
  before_action :find_work, only:[:show]
  
  def index
    @works = Work.all 
    @user = User.find(session[:user_id]) rescue nil
  end

  def show
    if @work.nil?
      head :not_found
      return
    end
  end

  def new
    @work = Work.new
  end

  def create
    @work = Work.new(work_params)

    if @work.save
      flash[:success] = "Work successfully saved!"
      redirect_to work_path(@work.id)
    else
      flash[:warning] = "Work failed to save"
      render :new
      return
    end
  end


  private

  def work_params
    return params.require(:work).permit(:title, :creator, :category, :publication_year, :description)
  end

  def find_work
    @work = Work.find_by(id: params[:id])
  end
end
