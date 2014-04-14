require 'spec_helper'

describe Task do
  let(:task) { FactoryGirl.create(:task) }

  subject { task }

  it { should be_valid }
  it { should respond_to(:name) }
  it { should respond_to(:start_date) }
  it { should respond_to(:end_date) }
  it { should respond_to(:user) }
  it { should respond_to(:project) }
  it { should respond_to(:add_to_project) }
  it { should respond_to(:add_user) }
  it { should respond_to(:remove_user) }

  describe "without the start date" do
  	before { task.start_date = "" }

  	it { should_not be_valid }
  end

  describe "without the end date" do
  	before { task.end_date = "" }

  	it { should_not be_valid }
  end

  describe "without the name" do
  	before { task.name = "" }

  	it { should_not be_valid }
  end

  describe "without the user" do
  	before { task.user_id = "" }

  	it { should_not be_valid }
  end

  describe "without the project" do
  	before { task.project_id = "" }

  	it { should_not be_valid }
  end

  describe "after adding to the project" do
  	let(:project) { FactoryGirl.create(:project) }
  	before do
  		task.project_id = 0
  		task.add_to_project(project)
  	end
  	
  	its(:project) { should eq project }
  end

  describe "after adding to the user" do
  	let(:user) { FactoryGirl.create(:user) }
  	before do
  		task.user_id = 0
  		task.add_user(user)
  	end
  	
  	its(:user) { should eq user }

  	describe "and after removing the user" do
  		before { task.remove_user(user) }

  		its(:user) { should_not eq user }
  	end
  end

  describe "after changing the end date to be before the start date" do
    before { task.end_date = task.start_date - 1 }

    it { should_not be_valid }
  end

  describe "after changing the end date to be exactly at the start date" do
    before { task.end_date = task.start_date }

    it { should be_valid }
  end
end
