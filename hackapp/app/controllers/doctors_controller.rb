class DoctorsController < ApplicationController
  def register
      @erro = false
  end

  def index
    @hash = Gmaps4rails.build_markers(@doctors) do |doctor, marker|
      marker.lat doctor.latitude
      marker.lng doctor.longitude
    end
  end

  def new

  doctor_search = Doctor.find_by(email: params[:doctor_form][:email])
  if doctor_search.nil?
      @doctor = Doctor.new(doctor_params)
      @total = Doctor.all
      @doctor.calendarID = @total.length + 1
      @doctor.save
      # UserNotifier.send_signup_email(@user).deliver

      @erro = false
      session[:user_type] = 'doctor'
      log_in @doctor
      @user_info = @doctor
 
    else
       @erro = true
       render 'register'
     end
   
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
    @hours = 7; # Horário de Início dos Expedientes
    @isScheduled = false;

    @rating = Feedback.where :userID

    if params[:format]
      @doctor = Doctor.find(params[:format])
    else
      @doctor = Doctor.find(params[:doctor])
    end

    @schedules = Schedules.where :calendarID => @doctor.calendarID
    @search_for_params = params[:format]

    # Implementar situação em que os agendamentos esgotaram

    if params[:date]
      @date = params[:date]
      @schedules = Schedules.where :calendarID => @doctor.calendarID
      @schedules = @schedules.where :date => @date
    else
      @date = ''
    end
  end

  def createSchedule
    # Realiza Agendamento
    @newSchedule = Schedules.new(schedule_params)
    @newSchedule.save

    # Recupera informações do Doctor
    @doctor = Doctor.find(params[:format])
    @schedule = @newSchedule
    #redirect_to :controller => 'doctors', :action => 'doctorDetails', :doctor => params[:doctor], :date => @date
  end

  def reviews
    @doctor = Doctor.find(params[:format])
  end

  def consultas
    @isSchedualed = false
    @doctor = Doctor.find(current_user.id)
    @schedules = Schedules.where :calendarID => @doctor.calendarID
  end
  
  private
    def doctor_params
      params.require(:doctor_form).permit(:name, :email, :password, :crm, :address, :healthPlans, :city, :neighborhood, :specialty)
    end

  private
    def schedule_params
      params.permit(:date, :hour, :calendarID, :userID)
    end
end

