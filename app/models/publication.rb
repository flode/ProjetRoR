# == Schema Information
#
# Table name: publications
#
#  id          :integer          not null, primary key
#  date        :string(255)
#  name        :string(255)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  type        :string(255)
#  publication :string(255)
#  month       :integer
#  notes       :string(255)
#  description :string(255)
#  nn          :string(255)
#

class Publication < ActiveRecord::Base
  self.inheritance_column = 'nn'
  attr_accessible :date, :name, :author_ids, :type, :publication, :month, :notes, :description

  has_and_belongs_to_many :authors

  validates :name, presence: true
end
