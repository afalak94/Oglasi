class AdvertisementsController < ApplicationController

	def index
		@advertisements = Advertisement.all.order("created_at DESC")
	end
end
