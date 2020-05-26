class VotesController < ApplicationController
  def upvote
    work = Work.find_by(id: params[:id])
    user = User.find_by(id: session[:user_id])

    if work.nil?
      head :not_found
      return
    end

    @vote = Vote.new(work_id: work.id, user_id: user.id)

    if @vote.save
      flash[:success] = "Upvote Successful"
      redirect_to work_path
      return
    else
      flash[:warning] = "Could not upvote"
      redirect_to work_path
      return
    end
  end
end
