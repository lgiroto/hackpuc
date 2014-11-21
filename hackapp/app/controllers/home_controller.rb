class HomeController < ApplicationController
  	def index
	  	allusers = Doctor.all
	  	
	  	@especialidades = Array.new
	  	@planos = Array.new
	  	@bairro = Array.new
	  	
	  	@espec_toprint = Array.new
	  	@plano_toprint = Array.new
	  	@bairro_toprint = Array.new

	  	@espec_toprint.push(['---',''])
	  	@plano_toprint.push(['---',''])
	  	@bairro_toprint.push(['---',''])

	  	allusers.each do |variable|
	  		@especialidades.push(variable[:specialty])
	  		@planos.push(variable[:healthPlans])
	  		@bairro.push(variable[:neighborhood])
	  	end

	  	@especialidades.each do |variable|
	  		@espec_toprint.push([variable,variable])
	  	end

	  	@planos.each do |variable|
	  		@plano_toprint.push([variable,variable])
	  	end

	  	@bairro.each do |variable|
	  		@bairro_toprint.push([variable,variable])
	  	end
	end
end
