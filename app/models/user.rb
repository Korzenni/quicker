class User < ActiveRecord::Base
	validates :email, :project_id, :uri, presence: true

	belongs_to :project
	has_many :tasks

	attr_accessor :client_uri

	def add_project(project)
		self.project = project
		self.save
	end

	def add_task(task)
		self.tasks << task
		task.save
	end

	def remove_task(task)
		if self.tasks.include?(task)
			self.tasks.delete(task)
		end
	end
end
