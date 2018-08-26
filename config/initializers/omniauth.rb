Rails.application.config.middleware.use OmniAuth::Builder do
 provider :google_oauth2, ENV['GOOGLE_APP_ID'], ENV['GOOGLE_APP_SECRET']
 provider :facebook, ENV['FACEBOOK_KEY'], ENV['FACEBOOK_SECRET'],
 	scope: 'email,user_birthday,user_gender', info_fields: 'email, first_name, last_name, gender, birthday, picture'


end