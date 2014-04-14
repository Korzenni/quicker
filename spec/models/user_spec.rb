require 'spec_helper'

describe User do
	let(:user) { FactoryGirl.create(:user) }
  let(:project) { FactoryGirl.create(:project) }
  
  subject { user }

  it { should be_valid }
  it { should respond_to(:name) }
  it { should respond_to(:project) }
  it { should respond_to(:email) }
  it { should respond_to(:project) }
  it { should respond_to(:uri) }
  it { should respond_to(:add_project) }
  it { should respond_to(:add_task) }

  describe "without the email" do
  	before { user.email = "" }

  	it { should_not be_valid }
  end

  describe "without the uri" do
  	before { user.uri = "" }

  	it { should_not be_valid }
  end

  describe "without the project" do
  	before { user.project_id = "" }

  	it { should_not be_valid }
  end

  describe "after adding the project" do
    before { user.add_project(project) }

    its(:project) { should eq(project) }
  end

  describe "after adding the task" do
    let(:task) { FactoryGirl.create(:task) }
    before do 
      task.add_to_project(project)
      user.add_task(task)
    end

    its(:tasks) { should include(task) }

    describe "and after removing" do
      before { user.remove_task(task) }

      its(:tasks) { should_not include(task) }
    end
  end
end
