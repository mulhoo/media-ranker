class VotesController < ApplicationController
  def create
    if session[:user_id].nil?
      flash[:warning] = "You must be logged in to Vote"
      redirect_to work_path
      return
    end

    @work = Work.find(params[:id])
    @user = User.find(session[:user_id])

    if @work.nil?
      head :not_found
      return
    end

    vote = Vote.new(work: @work, user: @user)

    if vote.save
      flash[:success] = "Upvote Successful"
      redirect_to work_path(@work.id)
      return
    else
      flash[:warning] = "Could not upvote"
      redirect_to work_path(@work.id)
      return
    end
  end
end
