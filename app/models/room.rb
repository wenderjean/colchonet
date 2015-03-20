class Room < ActiveRecord::Base
	extend FriendlyId

	belongs_to :user
	has_many :reviews, dependent: :destroy
	has_many :reviewed_room, through: :reviews, source: :room

	scope :most_recent, -> { order("created_at desc") }

	friendly_id :title, use: [:slugged, :history]
	
	def full_name
		"#{title}, #{location}"
	end

	def self.search(query)
		if query.present?
			where(['location LIKE :query OR title LIKE :query OR description LIKE :query', query: "%#{query}%"])
		else
			all
		end
	end
end
