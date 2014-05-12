class TasksController < ApplicationController
  expose(:current_user) { User.find_by_uri params[:client_uri] }
  expose(:project) { current_user.project }
  expose(:tasks) { project.tasks }
  expose(:task)

  def new
    task.client_uri = params[:client_uri]
  	if project.is_admin?(current_user)
  		respond_to do |format|
    		format.js
    	end
  	else
    	respond_to do |format|
		   	format.js { render 'shared/error' }
		  end
    end
  end

  def index
    respond_to do |format|
      # format.js { render 'tasks' }
      format.json { render json: tasks }
    end
  end

  def create
  	current_user = User.find_by_uri params[:task][:client_uri]
  	project = current_user.project
  	if(project.is_admin?(@current_user))
  		project.add_task(@task)
  		if task.save
  			tasks = project.tasks
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
  		params.require(:task).permit(:name, :user_id, :project_id, :client_uri, :start_date, :end_date) if params[:task]
  	end
end
