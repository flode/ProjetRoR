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
