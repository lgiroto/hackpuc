class DoctorsController < ApplicationController
  def register
  end

  def new
    @doctor = Doctor.new(doctor_params)
    @doctor.save
      # UserNotifier.send_signup_email(@user).deliver
  end

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
  
  private
    def doctor_params
      params.require(:doctor_form).permit(:name, :email, :password, :crm, :address, :healthPlans, :city, :neighborhood, :specialty)
    end
end

