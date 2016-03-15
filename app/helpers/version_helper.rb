module VersionHelper
	def find_version_author_name(version)
		user = User.find(version.terminator)
		user ? user.email : "<unknown user>"
	end
end
