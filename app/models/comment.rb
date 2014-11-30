class Comment < ActiveRecord::Base
  has_and_belongs_to_many :posts
  validates :body, presence: true
  validates :post_id, presence: true
end
