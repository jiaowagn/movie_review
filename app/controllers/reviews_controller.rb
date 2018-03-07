class ReviewsController < ApplicationController
  before_action :set_review, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  before_action :set_movie

  def new
    @review = Review.new
  end

  def edit
  end

  def create
    @review = Review.new(review_params)
    @review.user = current_user
    @review.movie = @movie
    if @review.save
      redirect_to movie_path(@movie)
    else
      render :new
    end
  end

  def update
    respond_to do |format|
      if @review.update(review_params)
        redirect_to movie_path(@movie)
      else
        render :edit
      end
    end
  end

  def destroy
    @review.destroy
    redirect_to movie_path(@movie)
  end

  private
    def set_review
      @review = Review.find(params[:id])
    end

    def set_movie
      @movie = Movie.find(params[:movie_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def review_params
      params.require(:review).permit(:comment, :rating)
    end
end
