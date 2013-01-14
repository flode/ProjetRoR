class Publication < ActiveRecord::Base
  self.inheritance_column = 'nn'
  attr_accessible :date, :name, :author_ids, :type, :publication, :month, :notes, :description

  has_and_belongs_to_many :authors

  validates :name, presence: true
end
