require 'spec_helper'
require 'pp'

describe TasksController do
  render_views

  describe "GET 'index'" do
    let!(:project) { FactoryGirl.create(:project) }
    let!(:user) { FactoryGirl.create(:user, project: project) }
    let!(:task_one) { FactoryGirl.create(:task, start_date: 9.days.ago.to_date.to_s("%Y-%m-%d"), end_date: 8.days.from_now.to_date.to_s("%Y-%m-%d"), user: user, project: project) } # start and end date out of range
    let!(:task_two) { FactoryGirl.create(:task, start_date: 9.days.ago.to_date.to_s("%Y-%m-%d"), end_date: 2.days.from_now.to_date.to_s("%Y-%m-%d"), user: user, project: project) } # start date out of range, end date in range
    let!(:task_three) { FactoryGirl.create(:task, start_date: 1.day.ago.to_date.to_s("%Y-%m-%d"), end_date: 5.days.from_now.to_date.to_s("%Y-%m-%d"), user: user, project: project) } # end date out of range, start date in range
    let!(:task_four) { FactoryGirl.create(:task, start_date: 15.days.ago.to_date.to_s("%Y-%m-%d"), end_date: 5.days.ago.to_date.to_s("%Y-%m-%d"), user: user, project: project) } # end date out of range, start date out of range in past
    let!(:task_five) { FactoryGirl.create(:task, start_date: 15.days.from_now.to_date.to_s("%Y-%m-%d"), end_date: 25.days.from_now.to_date.to_s("%Y-%m-%d"), user: user, project: project) } # end date out of range, start date out of range in future
    let!(:task_six) { FactoryGirl.create(:task, start_date: 2.days.ago.to_date.to_s("%Y-%m-%d"), end_date: 7.days.from_now.to_date.to_s("%Y-%m-%d"), user: user, project: project) } # end date and start date on range borders

    before(:each) do
      get :index, :client_uri => "my-uri", :start_date => 2.days.ago.to_date.to_s("%Y-%m-%d"), :end_date => 7.days.from_now.to_date.to_s("%Y-%m-%d"), :format => 'json' # 10 days table for testing
    end

    it "should be success" do
      expect(response).to be_success
    end

    it "should respond with only 4 tasks" do
      body = JSON.parse(response.body)
      expect(body.length).to eq(4)
    end

    it "should respond with Task 1" do      
      body = JSON.parse(response.body)
      names_array = body.map { |task| task["name"] }
      expect(names_array).to include(task_one.name)
    end

    it "should respond with Task 2" do      
      body = JSON.parse(response.body)
      names_array = body.map { |task| task["name"] }
      expect(names_array).to include(task_two.name)
    end

    it "should respond with Task 3" do      
      body = JSON.parse(response.body)
      names_array = body.map { |task| task["name"] }
      expect(names_array).to include(task_three.name)
    end

    it "should not respond with Task 4" do
      body = JSON.parse(response.body)
      names_array = body.map { |task| task["name"] }
      expect(names_array).not_to include(task_four.name)
    end

    it "should not respond with Task 5" do
      body = JSON.parse(response.body)
      names_array = body.map { |task| task["name"] }
      expect(names_array).not_to include(task_five.name)
    end

    it "should respond with Task 6" do
      body = JSON.parse(response.body)
      names_array = body.map { |task| task["name"] }
      expect(names_array).to include(task_six.name)
    end
  end
end
