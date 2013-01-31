class MoviesController < ApplicationController
    #before_filter :loadr , :only => :index 
  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
    @sort = params[:sort] || session[:sort]
    @rate1 = params[:ratings] || session[:ratings]
    
    @all_ratings = Movie.aratings()
    
    if params[:sort]==nil and @sort!=nil
        redirect_to :sort => @sort, :ratings => @rate1 and return
    end
    if params[:ratings]==nil and @rate1!=nil
        redirect_to :sort => @sort, :ratings => @rate1 and return
    elsif params[:ratings]==nil and @rate1==nil
        @rate=@all_ratings
    else
        @rate=params[:ratings].keys
    end
    session[:sort]=@sort
    session[:ratings]=@rate1
    
    if  @sort==nil
        @movies = Movie.find(:all, :conditions => ["rating IN (?)", @rate])
    elsif @sort=="byname"
        @sort="byname"
        @movies = Movie.find(:all, :conditions => ["rating IN (?)", @rate], :order => "title")
    elsif @sort=="bydate"
        @sort="bydate"
        @movies = Movie.find(:all, :conditions => ["rating IN (?)", @rate], :order => "release_date")   
    end  
    
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
