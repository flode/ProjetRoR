require 'spec_helper'

describe "Authors" do

  subject { page }
  let(:user) { FactoryGirl.create(:user) }
  describe "Profile page with name" do
    let(:author) { FactoryGirl.create (:author) }
    before { visit authors_path }
    it { should have_content('name') }
  end

  describe "new author"
   let(:submit) { "Create new author" }
   before(:each) do
      sign_in user
      visit '/authors/new'
    end
    
    describe "with invalid information" do
      it "should not create an author" do
        expect { click_button submit }.not_to change(Author, :count)
      end
      
      describe "after submission" do
        before { click_button submit }

        it { should have_content('error') }
      end
    end

    describe "with valid information" do
      before do
        fill_in "author_forename", with: "F"
        fill_in "author_surname", with: "L"
      end

      it "should create an author" do
        expect { click_button submit }.to change(Author, :count).by(1)
      end
      
      describe "after saving the author" do
        before { click_button submit }
        let(:author) { Author.find_by_forename_and_surname('F', 'L') }

        it { should have_selector('title', text: author.lastname) }
#	expect(author.user_id).to eq(user.id)
        it { should have_selector('div.alert.alert-success', text: 'New author created!') }
    end
  end
end
