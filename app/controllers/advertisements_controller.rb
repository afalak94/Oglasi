class AdvertisementsController < ApplicationController
	before_action :find_ad, only: [:show, :edit, :update, :destroy]
	before_action :authenticate_user!, only: [:new, :edit]

	def index
		if params[:category].blank?
			@advertisements = Advertisement.all.order("created_at DESC")
		else
			@category_id = Category.find_by(name: params[:category]).id
			@advertisements = Advertisement.where(:category_id => @category_id).order("created_at DESC")
		end
	end

	def show
		@reviews = Review.where(advertisement_id: @advertisement.id).order("created_at DESC")

		if @advertisement.reviews.blank?
			@avg_review = 0
		else
			@avg_review = @advertisement.reviews.average(:rating).round(2)
		end
	end

	def new
		@advertisement = current_user.advertisements.build
		@categories = Category.all.map { |c| [c.name, c.id] }
	end

	def create
		@advertisement = current_user.advertisements.build(advertisement_params)
		@advertisement.category_id = params[:category_id]

		if @advertisement.save
			redirect_to root_path
		else
			render 'new'
		end
	end

	def edit
		@categories = Category.all.map { |c| [c.name, c.id] }
	end

	def update
		@advertisement.category_id = params[:category_id]

		if @advertisement.update(advertisement_params)
			redirect_to advertisement_path(@advertisement)
		else
			render 'new'
		end
	end

	def destroy
		@advertisement.destroy
		redirect_to root_path
	end

	private
	def advertisement_params
		params.require(:advertisement).permit(:title, :body, :image, :user_id, :category_id)
	end

	def find_ad
		@advertisement = Advertisement.find(params[:id])
	end
end
