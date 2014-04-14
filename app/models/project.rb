class Project < ActiveRecord::Base
	validates :name, :admin_email, :admin_uri, presence: true

	has_many :users
	has_many :tasks

	def add_user(user)
		self.users << user
		user.save
		self.save
	end

	def set_admin(user)
		if(self.users.include?(user))
			self.admin_email = user.email
			user.uri = self.admin_uri
			user.save
			self.save
		end
	end

	def is_admin?(user)
		return (self.admin_uri == user.uri)
	end

	def remove_user(user)
		if((self.users.include?(user)) and (not self.is_admin?(user)))
			self.users.destroy(user)
		end
	end

	def add_task(task)
		self.tasks << task
		task.save
		self.save
	end

	def remove_task(task)
		if self.tasks.include?(task)
			self.tasks.destroy(task)
		end
	end
end
