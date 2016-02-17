class Post < ActiveRecord::Base

    has_many :comments, dependent: :destroy
    has_many :likes, dependent: :destroy
    belongs_to :user

	validates :content, presence: true, length: { maximum: 150 }

end