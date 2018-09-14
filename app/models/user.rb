class User < ApplicationRecord
	
	include Clearance::User

	mount_uploader :avatar, AvatarUploader
	has_many :reservations
	validates :first_name, presence: true
	validates :last_name, presence: true
	validates :email, presence: true
	enum role: ["customer","admin"]

	has_many :authentications, dependent: :destroy

	######## OmniAuth Auth hash grab info #######################
	def self.create_with_auth_and_hash(authentication, auth_hash)
		birthday = auth_hash['extra']['raw_info']["birthday"]
		if birthday.nil?
	     	birthday = Date.new(1970,1,1)
	    end
	    gender = auth_hash['extra']['raw_info']['gender']
	    if gender.nil?
	    	gender = "unknown"
	    end

		user = self.create!(
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

	def current_password
		self.password
	end



	##### Admin panel custom label ######
	def custom_label_method
    "#{self.email}"
    end

    def fullname
		[first_name, last_name].join(' ')
	end
    
end
