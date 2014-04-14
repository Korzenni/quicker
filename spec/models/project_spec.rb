require 'spec_helper'

describe Project do
  let(:user) { FactoryGirl.create(:user) }
  let(:project) { FactoryGirl.create(:project) }

  subject { project }

  it { should be_valid }
  it { should respond_to(:name) }
  it { should respond_to(:admin_email) }
  it { should respond_to(:admin_name) }
  it { should respond_to(:admin_uri) }
  it { should respond_to(:users) }
  it { should respond_to(:add_user) }
  it { should respond_to(:set_admin) }
  it { should respond_to(:is_admin?) }
  it { should respond_to(:remove_user) }

  describe "without the name" do
  	before do
  		project.name = ""
  	end

  	it { should_not be_valid }
  end

  describe "without the admin email" do
    before do
      project.admin_email = ""
    end

    it { should_not be_valid }
  end

  describe "without the admin_uri" do
    before do
      project.admin_uri = ""
    end

    it { should_not be_valid }
  end

  describe "when adds a user" do
    before { project.add_user(user) }

    its(:users) { should include(user) }

    describe "and does not set a user admin" do
      specify { project.is_admin?(user).should be_false } 

      describe "and removes him" do
        before { project.remove_user(user) }

        its(:users) { should_not include(user) }
      end
    end

    describe "and sets it as an admin" do
      before { project.set_admin(user) }

      specify { project.is_admin?(user).should be_true } 

      describe "tries to delete an admin" do
        before { project.remove_user(user) }

        its(:users) { should include(user) }
        specify { project.is_admin?(user).should be_true } 
      end
    end

    describe "and then adds a task" do
      let(:task) { FactoryGirl.create(:task) }
      before { project.add_task(task) }

      its(:tasks) { should include(task) }

      describe "and removes it" do
        before { project.remove_task(task) }

        its(:tasks) { should_not include(task) }
      end
    end
  end
end
