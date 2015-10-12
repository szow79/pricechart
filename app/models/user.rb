require 'bcrypt'

class User < ActiveRecord::Base
  # Remember to create a migration!
  include BCrypt

  has_many :items
  has_many :records, through: :items

  validates :email, presence: true, uniqueness: true
  validates :password, presence: true

  def password
    @password ||= Password.new(password_hash)
  end

  def password=(new_password)
    @password = Password.create(new_password)
    self.password_hash = @password
  end

  def add_item(properties)
    item = self.items.create(name: properties[:name], description: properties[:description], url: properties[:url])
    item.records.create(price: properties[:price])
  end
end
