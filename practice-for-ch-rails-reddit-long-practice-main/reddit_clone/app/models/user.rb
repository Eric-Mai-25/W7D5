# == Schema Information
#
# Table name: users
#
#  id              :bigint           not null, primary key
#  username        :string           not null
#  password_digest :string           not null
#  session_token   :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
class User < ApplicationRecord 
    before_validation :ensure_session_token!
    validates :username, presence: true, uniqueness: true
    validates :password_digest, presence: true
    validates :session_token, presence: true, uniqueness: true
    validates :password, length: {minimum: 6}, allow_nil: true
    attr_reader :password

    has_many :goals,
        class_name: :Goal,
        foreign_key: :user_id,
        dependent: :destroy,
        inverse_of: :user

    has_many :posts,
        class_name: :Post,
        foreign_key: :author_id,
        inverse_of: :author,
        dependent: :destroy


    def self.find_by_credentials(username, password)
        user = User.find_by(username: username)
        if user && user.is_password?(password)
            user
        else
            nil
        end
    end

    def password=(password)
        @password = password
        self.password_digest = BCrypt::Password.create(password)
    end

    def is_password?(password)
        pass_obj = BCrypt::Password.new(self.password_digest)
        pass_obj.is_password?(password)
    end

    def reset_session_token!
        self.session_token = generate_session_token
        self.save!
        self.session_token
    end

    def ensure_session_token!
        self.session_token ||= generate_session_token
    end

    def generate_session_token
        loop do
            token = SecureRandom::urlsafe_base64
            return token unless Users.exists?(session_token: token)
        end
    end
end
