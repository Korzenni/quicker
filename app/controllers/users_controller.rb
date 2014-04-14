class UsersController < ApplicationController
  def new
    @user = User.new
    @user.client_uri = params[:client_uri]
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
    @current_user = User.find_by_uri params[:user][:client_uri]
  	@project = @current_user.project
  	if @project.is_admin?(@current_user)
      @user = User.new(user_params)
	  	@user.uri = Digest::SHA1.hexdigest([Time.now, rand].join)
      @project.add_user(@user)
	    if @user.save
        @users = @project.users
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

  def show
  	@user = User.find params[:id]
  end

  def edit
    @current_user = User.find_by_uri params[:client_uri]
    @user = User.find params[:id]
    @user.client_uri = params[:client_uri]
    @project = @current_user.project
  	if @project.is_admin?(@current_user) or @current_user == @user
  		respond_to do |format|
    		format.js
    	end
  	else
    	respond_to do |format|
		   	format.js { render 'shared/error' }
		  end
    end
  end

  def update
    @current_user = User.find_by_uri params[:user][:client_uri]
    @user = User.find params[:id]
    @project = @current_user.project
    if @project.is_admin?(@current_user) or @current_user == @user
      if @user.update_attributes(user_params)
        @users = @project.users
        respond_to do |format|
          format.js
        end
      else
        respond_to do |format|
          format.js { render 'edit' }
        end
      end
    else
      respond_to do |format|
        format.js { render 'shared/error' }
      end
    end
  end

  private

  	def user_params
  		params.require(:user).permit(:name, :email, :project_id, :client_uri) 
  	end
end
