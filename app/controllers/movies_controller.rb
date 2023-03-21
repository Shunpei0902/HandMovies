class MoviesController < ApplicationController
  before_action :set_movie, only: %i[ show edit update destroy ]

  # GET /movies or /movies.json
  def index
    @movies = Movie.all
    if params[:search]
      @movies = @movies.where("title LIKE ?", "%#{params[:search]}%")
    end
    
  end

  # GET /movies/1 or /movies/1.json
  def show
    @movies = Movie.find(params[:id])
  end

  # GET /movies/new
  def new
    @movies = Movie.new
  end

  # GET /movies/1/edit
  def edit
  end

  # POST /movies or /movies.json
  def create
    @movies = Movie.new(movie_params)

    respond_to do |format|
      if @movies.save
        format.html { redirect_to movie_url(@movies), notice: "Movie was successfully created." }
        format.json { render :show, status: :created, location: @movies }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @movies.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /movies/1 or /movies/1.json
  def update
    respond_to do |format|
      if @movies.update(movie_params)
        format.html { redirect_to movie_url(@movies), notice: "Movie was successfully updated." }
        format.json { render :show, status: :ok, location: @movies }
      else
        @movies = movie.all
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @movies.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /movies/1 or /movies/1.json
  def destroy

    @movies = Movie.find(params[:id])
    @movies.destroy

    respond_to do |format|
      format.html { redirect_to movies_url, notice: "Movie was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_movie
      @movie = Movie.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def movie_params
      params.require(:movie).permit(:title, :introduction, movies: [])
    end
end
