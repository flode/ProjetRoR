class Author < ActiveRecord::Base
  attr_accessible :description, :forename, :surname, :user_id
  belongs_to :user
  has_and_belongs_to_many :publications
  validates :forename, presence: true
  validates :surname, presence: true
  validates :user_id, presence: true
end
