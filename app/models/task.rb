class Task < ActiveRecord::Base
	validates :name, :project_id, :user_id, :start_date, :end_date, presence: true
	validate :end_date_after_start_date

	belongs_to :user
	belongs_to :project

	attr_accessor :client_uri

	def add_to_project(project)
		self.project = project
		self.save
	end

	def add_user(user)
		self.user = user
		self.save
	end

	def remove_user(user)
		if self.user == user
			self.user_id = 0
			self.save
		end
	end

	def end_date_after_start_date
		if errors[:end_date].empty? and errors[:start_date].empty?
			if end_date < start_date
	      errors.add(:end_date, "End date must be after the start date!")
	    end
	  end
	end
end
