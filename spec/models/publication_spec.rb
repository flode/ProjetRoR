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
