class TasksController < ApplicationController
  def new
  	@task = Task.new
    @task.client_uri = params[:client_uri]
    @current_user = User.find_by_uri params[:client_uri]
  	@project = @current_user.project
  	if @project.is_admin?(@current_user)
  		respond_to do |format|
    		format.js
    	end
  	else
    	respond_to do |format|
		   	format.js { render 'shared/error' }
		  end
    end
  end

  def create
  	@current_user = User.find_by_uri params[:task][:client_uri]
  	@project = @current_user.project
  	if(@project.is_admin?(@current_user))
  		@task = Task.new task_params
  		@project.add_task(@task)
  		if @task.save
  			@tasks = @project.tasks
	      respond_to do |format|
		     	format.js
		    end
  		else
  			respond_to do |format|
		     	format.js { render 'new' }
		    end
  		end
  	else
  		respond_to do |format|
		   	format.js { render 'shared/error' }
		  end
  	end
  end

  def edit
  end

  def update
  end

  private

  	def task_params
  		params.require(:task).permit(:name, :user_id, :project_id, :client_uri, :start_date, :end_date) 
  	end
end
