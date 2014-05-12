require 'spec_helper'
require 'pp'

describe TasksController do
  render_views

  describe "GET 'index'" do
    let!(:project) { FactoryGirl.create(:project) }
    let!(:user) { FactoryGirl.create(:user, project: project) }
    let!(:task_one) { FactoryGirl.create(:task, user: user, project: project) } 
    let!(:task_two) { FactoryGirl.create(:task, user: user, project: project) } 
    before(:each) do
      get :index, :client_uri => "my-uri", :format => 'json'
    end

    it "should be success" do
      expect(response).to be_success
    end

    it "should respond with all the tasks" do      
      body = JSON.parse(response.body)
      expect(body.length).to eq(2)
      expect(body[0]).to include("name" => "Task 1")
    end
  end
end
