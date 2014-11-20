class DoctorsController < ApplicationController
  def results
  	@doctorsResults = Doctor.all
  	if params[:neighborhood] && params[:neighborhood] != ''
  		@doctorsResults = @doctorsResults.select { |doctorsResult| doctorsResult.neighborhood == params[:neighborhood] }
  	end
  	if params[:specialty] && params[:specialty] != ''
  		@doctorsResults = @doctorsResults.select { |doctorsResult| doctorsResult.specialty == params[:specialty] }
  	end
  	if params[:healthPlans]&& params[:healthPlans] != ''
  		@doctorsResults = @doctorsResults.select { |doctorsResult| doctorsResult.healthPlans == params[:healthPlans] }
  	end
  	if params[:search_form]
  		@doctorsResults = Doctor.where('name LIKE ?', "%#{params[:search_form][:name]}%")
  	end
  end

  def doctorDetails
    @doctor = Doctor.find(params[:format])
  end
end

