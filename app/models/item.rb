class Item < ActiveRecord::Base
  # Remember to create a migration!
  has_many :data
  belongs_to :user

  validates :url, presence: true
end
