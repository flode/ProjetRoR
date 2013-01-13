require 'spec_helper'

describe Author do
  before { @author = Author.new(surname: "Name", forename: "Hans", user_id: 1 ) } 
  subject { @author }

  it { should respond_to(:surname) }
  it { should respond_to(:forename) }
  it { should respond_to(:user_id) }
  it { should respond_to(:description) }
  it { should respond_to(:lab) }
  it { should respond_to(:user) }

  it { should be_valid }

end
