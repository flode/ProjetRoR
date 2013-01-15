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

require 'spec_helper'

describe Publication do
  before { @publication = Publication.new(name: "Book number 1", date: "1991") }

  subject { @publication }

  it { should respond_to(:name) }
  it { should respond_to(:date) }
  it { should respond_to(:type) }
  it { should respond_to(:publication) }
  it { should respond_to(:month) }
  it { should respond_to(:notes) }
  it { should respond_to(:description) }
  it { should respond_to(:authors) }

  it { should be_valid }

  describe "when name is not present" do
    before { @publication.name = " " }
    it { should_not be_valid }
  end

# TODO association
end
