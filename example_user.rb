class User

	attr_accessor :name, :email			# cria um getter e um setter para as 								variaveis

	def initialize (attributes = {}) 		# construtor pode ser usado com "User.new"
		@name = attributes[:name]		# só precisa de um argumento
		@email = attributes[:email]  		# desta forma é possivel criar um user 
	end 						# null
	

	def formated_email 
		"#{@name} <#{@email}>"			# string interpolation
	end
end

