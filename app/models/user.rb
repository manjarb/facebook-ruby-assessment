require 'bcrypt'

class User < ActiveRecord::Base
	include BCrypt
	# This is Sinatra! Remember to create a migration!

	attr_accessor :password
    attr_writer :password_hash

    has_many :posts, dependent: :destroy
    has_many :comments, dependent: :destroy
    has_many :likes, dependent: :destroy

	validates :username, presence: true, uniqueness: true
	validates :email, :format => { :with => /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i ,
    :message => "Email wrong format" }
    validates :email, uniqueness: true,presence: true
    validates :encrypted_password, presence: true

    def password
        @password ||= Password.new(encrypted_password)
    end

    def password=(new_password)
        @password = Password.create(new_password)
        self.encrypted_password = @password
    end

    def list
        User.all
    end

    def self.authenticate(email,password)
        
    end

end
