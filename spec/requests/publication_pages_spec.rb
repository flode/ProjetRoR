require 'spec_helper'

describe "Publication pages" do

  subject { page }
  let(:user) { FactoryGirl.create(:user) }

  describe "index" do
    describe "not logged in" do
      before do
        visit publications_path
      end
      it { should_not have_selector('a', text: 'Add Publication') }
    end

    describe "logged_in" do
      before do
        sign_in user
        visit publications_path
      end
     it { should have_selector('a', text: 'Add Publication') }
    end
  end

  describe "publication page" do
    let (:pub) { FactoryGirl.create(:publication) }
    before do
      visit publication_path(pub)
    end

    it { should have_selector('h1', text: pub.name) }
    it { should_not have_selector('a', text: 'Edit') }
    it { should have_content(pub.name) }
    it { should have_content(pub.date) }

    it "have authors list" do
      pub.authors.each do |author|
        page.should have_content(author.surname)
      end
    end
  end

  describe "publication page logged_in other user" do
    let (:pub) { FactoryGirl.create(:publication) }
    before do
      sign_in user
      visit publication_path(pub)
    end

    it { should_not have_selector('a', text: 'Edit') }
  end

  describe "publication page logged_in" do
    let (:pub) { FactoryGirl.create(:publication) }
    before do
      sign_in pub.authors[0].user
      visit publication_path(pub)
    end

    it { should have_selector('a', text: 'Edit') }
  end

  describe "new publication not signed in" do
    before do
      visit new_publication_path
    end
    it { should_not have_selector('title', text: full_title('New publication')) }
  end

  describe "new publication" do
    before do
      sign_in user
      visit new_publication_path
    end

    it { should have_selector('title', text: full_title('New publication')) }

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
        fill_in "publication_name",         with: "Example Publication"
        fill_in "publication_date",         with: "1991"
        fill_in "publication_type",         with: "Journal"
        fill_in "publication_publication",  with: "Science Journal"
        fill_in "publication_month",        with: "5"
        fill_in "publication_notes",        with: "nouveau"
        fill_in "publication_description",  with: "boring"
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

  describe "edit" do
    let (:pub) { FactoryGirl.create(:publication) }
    before do
      sign_in pub.authors[0].user
      visit edit_publication_path(pub)
    end
    
    describe "with invalid information" do
      before do
        fill_in "publication_name", with: ""
        click_button "Save changes"
      end

      it { should have_content('error') }
    end

    describe "with valid information" do
      let(:new_name)  { "New Name" }
      let(:new_date) { "1991" }
      before do
        fill_in "publication_name", with: new_name
        fill_in "publication_date", with: new_date
        click_button "Save changes"
      end

      it { should have_selector('title', text: new_name) }
      it { should have_selector('div.alert.alert-success') }
      specify { pub.reload.name.should  == new_name }
      specify { pub.reload.date.should == new_date }
    end

    describe "as wrong user" do
      let(:wrong_user) { FactoryGirl.create(:user, email: "wrong@example.com") }
      before { sign_in wrong_user }

      describe "visiting Publications#edit page" do
        before { visit edit_publication_path(pub) }
        it { should_not have_selector('title', text: full_title('Edit publication')) }
      end
    end
  end
end

