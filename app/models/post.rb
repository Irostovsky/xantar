class Post < ActiveRecord::Base
  has_many :payments
  validates :content, presence: true
end
