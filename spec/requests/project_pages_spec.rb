require 'spec_helper'
require 'database_cleaner'

DatabaseCleaner.strategy = :deletion

describe "Project pages" do
  before do
    DatabaseCleaner.clean
  end

	subject { page }

  describe "show page for non-admin" do
    let!(:project) { FactoryGirl.create(:project) }
    let!(:user) { FactoryGirl.create(:user) }

  	before do
      user.add_project(project)
      visit project_path(:id => user.uri)
    end
    
    it { should have_content(project.name)}
    it { should have_content(user.name)}
    it { should_not have_content("Add user") }
  end

  describe "new page" do
  	before { visit new_project_path }

  	let(:submit) { "Create new project" }

  	describe "with invalid data" do
  		it "should not create a new project" do
  			expect { click_button submit }.not_to change(Project, :count)
  		end
  	end

  	describe "with valid data" do
  		before do
  			fill_in "Name",       with: "Example project"
  			fill_in "Admin email", with: "email@email.com"
  		end

  		it "should create a new project" do
  			expect { click_button submit }.to change(Project, :count)
  		end

  		describe "after saving the project" do
  			before { click_button submit }

  			it { should have_content("Example project") }
  		end
  	end
  end
end
