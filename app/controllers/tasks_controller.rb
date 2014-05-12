class TasksController < ApplicationController
  expose(:current_user) do
    if params.has_key?(:client_uri)
      User.find_by_uri params[:client_uri]
    else
      User.find_by_uri params[:task][:client_uri]
    end
  end

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
    task = Task.new task_params # cant make decent exposure to expose it correctly - for further look

  	if project.is_admin?(current_user)
      
      task.project = project
      task.client_uri = params[:task][:client_uri]

      logger.debug task.attributes.inspect
      
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
