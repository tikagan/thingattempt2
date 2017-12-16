class User < ApplicationRecord
	has_secure_password

	validates :password, :presence => true,
	:length => {:within => 6..40},
	:on => :create
end
