class FeaturedController < ApplicationController
  def index
    @works = Work.all 
    @user = User.find(session[:user_id]) rescue nil

    @featured_work = Work.featured_work

    @sort_album = Work.sort("album")
    @sort_book = Work.sort("book")
    @sort_movie = Work.sort("movie")
  end
end
