# == Schema Information
#
# Table name: authors
#
#  id          :integer          not null, primary key
#  surname     :string(255)
#  forename    :string(255)
#  description :string(255)
#  user_id     :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  lab         :string(255)
#

class Author < ActiveRecord::Base
  attr_accessible :description, :forename, :surname, :user_id, :lab
  belongs_to :user
  has_and_belongs_to_many :publications
  validates :forename, presence: true
  validates :surname, presence: true
  validates :user_id, presence: true
end
