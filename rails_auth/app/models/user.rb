class User < ApplicationRecord 
    validates :username, presence: true, uniqueness: true 
    validates :password_digest, presence: true 
    validates :password, length: {minimum: 6}, allow_nil: true 
    validates :session_token, presence: true, uniqueness: true  




    def reset_session_token! 
        self.session_token = SecureRandom::urlsafe_base64(16)
        self.save! 
        self.session_token
    end

    def password=(password)
        @password = password    
        password_digest = BCrypt::Password.create(password)
    end

    def is_this_my_password?(pw)
        #verifies if given password equals the password in the attribute
        BCrypt::Password.new(self.password_digest).is_password?(pw)
    end

    def self.find_by_credentials(user_name, password)
        user1 = User.find_by(username: user_name)
        return nil unless user1 && user1.is_this_my_password?(password)
        user1
    end


    
    #helper method
    # def self.generate_session_token 
    #     SecureRandom::urlsafe_base64(16)
    # end
end
