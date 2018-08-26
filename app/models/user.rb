class User < ApplicationRecord
	
	include Clearance::User
	mount_uploader :avatar, AvatarUploader
	has_many :reservations
	validates :first_name, presence: true
	validates :last_name, presence: true
	validates :password, presence: true
	validates :email, presence: true
	enum role: ["customer","admin", "operator"]


	has_many :authentications, dependent: :destroy

	def self.create_with_auth_and_hash(authentication, auth_hash)
		birthday = auth_hash['extra']['raw_info']["birthday"]
		if birthday.nil?
	     	birthday = Date.new(1970,1,1)
	    end
	    gender = auth_hash['extra']['raw_info']['gender']
	    if gender.nil?
	    	gender = "unknown"
	    end
	    p auth_hash["info"]["picture"]
		user = self.create!(
		 # name: auth_hash["info"]["name"],
		 email: auth_hash["info"]["email"],
		 first_name: auth_hash["info"]["first_name"],
	     last_name: auth_hash["info"]["last_name"], 
         birthday: birthday,
         gender: gender,
	     phone_number: auth_hash["info"]["phone"],
		 password: SecureRandom.hex(10),
		 remote_avatar_url: auth_hash["info"]["image"]
		)
		user.authentications << authentication
		return user
	end

	# grab google to access google for user data
	def google_token
		x = self.authentications.find_by(provider: 'google_oauth2')
		return x.token unless x.nil?
	end
end
