class VotesController < ApplicationController
  def upvote
    work = Work.find_by(id: params[:id])

    if work.nil?
      head :not_found
      return
    end

    @vote = Vote.new(work_id: work.id, user_id: @user.id)

    if @vote.save
      flash[:success] = "Upvote Successful"
      redirect_back(fallback_location: root_path)
      return
    else
      flash[:warning] = "Could not upvote"

      if @vote.errors.any?
        @vote.errors.each do |col, mess|
          flash[col.to_sym] = mess
        end
      end
      
      redirect_back(fallback_location: root_path)
      return
    end
  end
end
