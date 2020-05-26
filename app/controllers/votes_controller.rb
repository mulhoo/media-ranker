class VotesController < ApplicationController
  def create
    work = Work.find_by(id: params[:id])
    user = User.find_by(id: params[:id])

    if work.nil?
      head :not_found
      return
    end

    vote = Vote.new(work: work, user: user)

    if vote.save
      flash[:success] = "Upvote Successful"
      redirect_to work_path(work.id)
      return
    else
      flash[:warning] = "Could not upvote"
      redirect_to work_path(work.id)
      return
    end
  end
end
