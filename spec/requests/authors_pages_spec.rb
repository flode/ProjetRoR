require 'spec_helper'

describe "Authors" do

  subject { page }
  let(:user) { FactoryGirl.create(:user) }

  describe "index author list" do
    before do
      30.times { FactoryGirl.create(:user) }
      visit authors_path
    end

    it { should have_selector('a', text: 'Add new author') }  

    it "have authors list of names" do
      Author.paginate(page: 1).each do |author|
        page.should have_content(author.surname)
      end
    end
  end

  describe "Profile page with name" do
    let(:author) { FactoryGirl.create (:author) }
    before do
      sign_in user
      visit author_path(author)
    end
    it { should have_content(author.surname) }

    it { should_not have_selector('a', text: 'Edit') }
    it { should_not have_selector('a', text: 'Add Publication') }

    it "have publications list" do
      author.publications.each do |pub|
        page.should have_content(pub.name)
      end
    end
  end

  describe "Profile page logged in" do
    let(:author) { FactoryGirl.create (:author) }
    before do
      sign_in author.user
      visit author_path(author)
    end
    it { should have_selector('a', text: 'Edit') } 
    it { should have_selector('a', text: 'Add Publication') } 
  end

  describe "new author"
   let(:submit) { "Create new author" }
   before(:each) do
      sign_in user
      visit new_author_path
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
        fill_in "author_lab", with: "Univ"
      end

      it "should create an author" do
        expect { click_button submit }.to change(Author, :count).by(1)
      end
      
      describe "after saving the author" do
        before { click_button submit }
        let(:author) { Author.find_by_forename_and_surname('F', 'L') }

        it { should have_selector('title', text: author.surname) }
#	expect(author.user_id).to eq(user.id)
        it { should have_selector('div.alert.alert-success', text: 'New author created!') }
    end
  end

  describe "edit" do
    let (:author) { FactoryGirl.create(:author) }
    before do
      sign_in author.user
      visit edit_author_path(author)
    end

    describe "with invalid information" do
      before do
        fill_in "author_surname", with: ""
        click_button "Save changes"
      end

      it { should have_content('error') }
    end

    describe "with valid information" do
      let(:new_surname)  { "Chantal" }
      let(:new_forename) { "Avis" }
      before do
        fill_in "author_surname", with: new_surname
        fill_in "author_forename", with: new_forename
        click_button "Save changes"
      end

      it { should have_selector('title', text: new_surname) }
      it { should have_selector('div.alert.alert-success') }
      specify { author.reload.surname.should  == new_surname }
      specify { author.reload.forename.should == new_forename }
    end

    describe "as wrong user" do
      let(:wrong_user) { FactoryGirl.create(:user, email: "wrong@example.com") }
      before { sign_in wrong_user }

      describe "visiting Authors#edit page" do
        before { visit edit_author_path(author) }
        it { should_not have_selector('title', text: full_title('Edit author')) }
      end
    end
  end
end
