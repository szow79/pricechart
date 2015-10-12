class Record < ActiveRecord::Base
  # Remember to create a migration!
  belongs_to :item
end
