class Comment < ActiveRecord::Base
  belongs_to :post
  belongs_to :creator, foreign_key: 'user_id', class_name: 'User'
  validates :body, presence: true
end
