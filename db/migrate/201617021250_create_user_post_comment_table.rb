class CreateUserPostCommentTable < ActiveRecord::Migration
	def change
		create_table :users do |t|
			t.string :username
			t.string :email
			t.string :encrypted_password
		end

		create_table :posts do |t|
			t.text :content
			t.references :user
			t.belongs_to :user, index: true
		end

		create_table :comments do |t|
			t.text :content
			t.references :user
			t.references :post
			t.belongs_to :posts, index: true
			t.belongs_to :users, index: true
		end

		create_table :likes do |t|
			t.references :user
			t.references :post
			t.belongs_to :posts, index: true
			t.belongs_to :users, index: true
		end
	end
end
