class Author < ActiveRecord::Base
  attr_accessible :description, :forename, :surname, :user_id
  validates :forename, presence: true
  validates :surname, presence: true
  validates :user_id, presence: true
end
