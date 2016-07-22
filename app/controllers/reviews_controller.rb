class ReviewsController < ApplicationController
	before_action :find_ad
	before_action :find_review, only: [:edit, :update, :destroy]
	before_action :authenticate_user!, only: [:new, :edit]

	def new
		@review = Review.new
	end

	def create
		@review = Review.new(review_params)
		@review.user_id = current_user.id
		@review.advertisement_id = @advertisement.id
		
		if @review.save
			redirect_to advertisement_path(@advertisement)
		else
			render 'new'
		end
	end

	def edit
		
	end

	def update
		if @review.update(review_params)
			redirect_to advertisement_path(@advertisement)
		else
			render 'edit'
		end
	end

	def destroy
		@review.destroy
		redirect_to advertisement_path(@advertisement)
	end

	private
	def review_params
		params.require(:review).permit(:rating, :comment, :user_id, :advertisement_id)
	end

	def find_ad
		@advertisement = Advertisement.find(params[:advertisement_id])
	end

	def find_review
		@review = Review.find(params[:id])
	end
end
