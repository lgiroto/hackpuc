class DoctorsController < ApplicationController
  def register
      @erro = false

      @validate = Hash.new
      @validate[:name] = 0
      @validate[:email] = 0
      @validate[:password] = 0
      @validate[:crm] = 0
      @validate[:city] = 0
      @validate[:neighborhood] = 0
      @validate[:address] = 0
      @validate[:healthPlans] = 0
      @validate[:specialty] = 0
  end

  def index
    @hash = Gmaps4rails.build_markers(@doctors) do |doctor, marker|
      marker.lat doctor.latitude
      marker.lng doctor.longitude
    end
  end

  def new
    

    @validate = Hash.new
    @temp = params[:doctor_form]

    if @temp[:name].blank?
      @validate[:name] = 1
    end
  
    if @temp[:password].blank?
      @validate[:password] = 1
    end

    if @temp[:crm].blank?
      @validate[:crm] = 1
    end

    if @temp[:email].blank?
      @validate[:email] = 1
    end

    if @temp[:city].blank?
      @validate[:city] = 1
    end

    if @temp[:neighborhood].blank?
      @validate[:neighborhood] = 1
    end

    if @temp[:address].blank?
      @validate[:address] = 1
    end

    if @temp[:healthPlans].blank?
      @validate[:healthPlans] = 1
    end

    if @temp[:specialty].blank?
      @validate[:specialty] = 1
    end

    if @temp[:name].blank? || @temp[:password].blank? || @temp[:email].blank? || @temp[:specialty].blank? || @temp[:healthPlans].blank? || @temp[:address].blank? || @temp[:neighborhood].blank? || @temp[:city].blank? || @temp[:crm].blank?
      render "register" 
      else



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
  end

  def results

    @validate = Hash.new
    @validate[:name] = 0
    @validate[:email] = 0
    @validate[:message] = 0

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

    @espec_toprint = @espec_toprint.uniq
    @plano_toprint = @plano_toprint.uniq
    @bairro_toprint = @bairro_toprint.uniq


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
    if params[:date]
      @date = params[:date]
    else
      @date = ''
    end
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

