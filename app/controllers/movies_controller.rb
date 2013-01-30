class MoviesController < ApplicationController
    #before_filter :loadr , :only => :index 
  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
    if params[:sort]==nil
        @movies = Movie.all
    elsif params[:sort]=="byname"
        @movies = Movie.find(:all, :order => "title")
    elsif params[:sort]=="bydate"
        @movies = Movie.find(:all, :order => "release_date")   
    end
    @all_ratings = Movie.aratings
  end

  def new
    # default: render 'new' template
  end

  def create
    @movie = Movie.create!(params[:movie])
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(params[:movie])
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end
  
  def loadr
    @all_ratings = Movie.aratings
  end
    
end
