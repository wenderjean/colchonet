class User < ActiveRecord::Base
	has_many :rooms, dependent: :destroy
        has_many :reviews, dependent: :destroy
	
	EMAIL_REGEXP = /^(|(([A-Za-z0-9]+_+)|([A-Za-z0-9]+\-+)|([A-Za-z0-9]+\.+)|([A-Za-z0-9]+\++))*[A-Za-z0-9]+@((\w+\-+)|(\w+\.))*\w{1,63}\.[a-zA-Z]{2,6})$/i

	validates_presence_of :email, :full_name, :location
	validates_length_of :bio, minimum: 30, allow_blank: false
	validates_uniqueness_of :email

	has_secure_password

	scope :confirmed, -> { where.not(confirmed_at: nil) }

	before_create do |user|
		user.confirmation_token = SecureRandom.urlsafe_base64
	end

	def confirm!
		return if confirmed?

		self.confirmed_at = Time.current
		self.confirmation_token = ''
		save!
	end

	def confirmed?
		confirmed_at.present?
	end

	def self.authenticate(email, password)
		user = confirmed
				.find_by(email: email)
				.try(:authenticate, password)
	end

	validate do
		errors.add(:email, :invalid) unless email.match(EMAIL_REGEXP)
	end
end
