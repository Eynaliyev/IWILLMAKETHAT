class User < ActiveRecord::Base
    
    has_many :posts, dependent: :destroy # remove a user's posts if his account is deleted.
	has_many :active_relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
	has_many :passive_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
         
	has_many :following, through: :active_relationships, source: :followed
	has_many :followers, through: :passive_relationships, source: :follower

    # helper methods
	def self.sign_in_from_omniauth(auth)
		find_by(provider: auth['provider'], uid: auth['uid'], profile_image: auth['info']['image']) || create_user_from_omniauth(auth)
	end

	def self.create_user_from_omniauth(auth)
		create(
			provider: auth['provider'],
			uid: auth['uid'],
			name: auth['info']['name'],
			profile_image: auth['info']['image']
			)
	end
    # follow another user
	def follow(other)
		active_relationships.create(followed_id: other.id)
	end
	# unfollow a user
	def unfollow(other)
		active_relationships.find_by(followed_id: other.id).destroy
	end  
	# is following a user?
	def following?(other)
		following.include?(other)
	end
end
