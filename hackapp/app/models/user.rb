class User < ActiveRecord::Base
	has_secure_password
	geocoded_by :adress
	after_validation :geocode
end
