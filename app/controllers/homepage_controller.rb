class HomepageController < ApplicationController
  def index
    @works = Work.all 
    @user = User.find(session[:user_id]) rescue nil

    @top_work = Work.top
    @sort_albums = Work.sort("album")
    @sort_books = Work.sort("book")
    @sort_movies = Work.sort("movie")
  end
end
