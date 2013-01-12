class Publication < ActiveRecord::Base
  attr_accessible :date, :name, :author_ids

  has_and_belongs_to_many :authors

  validates :name, presence: true
end
