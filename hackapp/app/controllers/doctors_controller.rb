class DoctorsController < ApplicationController
  def results
  	@doctorsResults = Doctor.all
  end
end
