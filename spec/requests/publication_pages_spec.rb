require 'spec_helper'

describe "Publication pages" do

  subject { page }

  describe "index" do
    
  end

  describe "publication page" do
    let (:pub) { FactoryGirl.create(:publication) }
    before { visit publication_path(pub) }

    it { should have_selector('h1', text: pub.name) }
    it { should have_content('') }

    it "have authors list" do
#TODO list
#      Author.find_all_by_user_id(user.id).each do |author|
#        page.should have_content(author.surname)
#      end
    end
  end
end

