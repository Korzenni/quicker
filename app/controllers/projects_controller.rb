class ProjectsController < ApplicationController
  def show
    @current_user = User.find_by_uri(params[:id])
    if not @current_user
      @project = Project.find_by_admin_uri params[:id]
    else
      @project = @current_user.project
    end
    @admin_user = User.new(name: @project.admin_name, email: @project.admin_email)
    @users = @project.users
  end

  def new
    @project = Project.new
  end

  def create
    @project = Project.new(project_params)
    @project.admin_uri = Digest::SHA1.hexdigest([Time.now, rand].join)
    if @project.save
      @user = User.new(email: @project.admin_email)
      @project.add_user(@user)
      @project.set_admin(@user)
      @user.save
      redirect_to project_path(:id => @project.admin_uri)
    else
      render 'new'
    end
  end


  private
    def project_params
      params.require(:project).permit(:name, :admin_email, :admin_uri, :admin_name) 
    end
end
