class Post < ActiveRecord::Base


	validates :content, presence: true, length: { maximum: 150 }

end