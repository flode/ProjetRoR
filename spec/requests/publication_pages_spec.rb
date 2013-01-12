require 'spec_helper'

describe "Publication pages" do

  subject { page }
  let(:user) { FactoryGirl.create(:user) }

  describe "index" do
    
  end

  describe "publication page" do
    let (:pub) { FactoryGirl.create(:publication) }
    before do
      sign_in user
      visit publication_path(pub)
    end

    it { should have_selector('h1', text: pub.name) }
    it { should have_content('') }

    it "have authors list" do
      pub.authors.each do |author|
        page.should have_content(author.surname)
      end
    end
  end

  describe "new publication" do
    before do
      sign_in user
      visit new_publication_path
    end

    let(:submit) { "Create new publication" }

    describe "with invalid information" do
      it "should not create a publication" do
        expect { click_button submit }.not_to change(Publication, :count)
      end
      
      describe "after submission" do
        before { click_button submit }

        it { should have_selector('title', text: 'New publication') }
        it { should have_content('error') }
      end
    end

    describe "with valid information" do
      before do
        fill_in "Name",         with: "Example Publication"
        fill_in "Date",        with: "1991"
      end

      it "should create a publication" do
        expect { click_button submit }.to change(Publication, :count).by(1)
      end
      
      describe "after saving the publication" do
        before { click_button submit }
        let(:publication) { Publication.find_by_name('Example Publication') }

        it { should have_selector('title', text: publication.name) }
        it { should have_selector('div.alert.alert-success', text: 'New publication created!') }
        it { should have_link('Sign out') }
      end

    end

  end
end

