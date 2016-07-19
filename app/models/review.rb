class Review < ActiveRecord::Base
	belongs_to :advertisement
	belongs_to :user
end
