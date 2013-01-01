require 'spec_helper'

describe "Authors" do
  let(:author) { FactoryGirl.create (:author) }
  describe "Profile page with name" do
    before { visit authors_path }
    it { should have_text('name') }
  end
end
