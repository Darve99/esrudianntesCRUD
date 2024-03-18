require 'httparty'

class StudentsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    @students = Student.all
    render json: @students
  end

  def create
    command = CreateStudentCommand.new(student_params)
    if command.execute
      send_webhook_notification('student_created', student_params)
      redirect_to students_path, notice: 'Student was successfully created.'
    else
      render :new
    end
  end

  def new
    @student = Student.new
  end

  def edit
    @student = GetStudentByIdQuery.new(params[:id]).call
  end

  def update
    command = UpdateStudentCommand.new(params[:id], params[:student])
    if command.execute
      send_webhook_notification('student_updated', params[:student])
      redirect_to students_path, notice: 'Student was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    command = DeleteStudentCommand.new(params[:id])
    if command.execute
      send_webhook_notification('student_deleted', { id: params[:id] })
      redirect_to students_path, notice: 'Student was successfully destroyed.'
    else
      redirect_to students_path, alert: 'Failed to delete student.'
    end
  end

  private

  def student_params
    params.require(:student).permit(:name, :email, :age)
  end

  def send_webhook_notification(event_type, data)
    webhook_url = 'http://your-webhook-endpoint.com/webhooks/handle'
    payload = { event_type: event_type, data: data }
    response = HTTParty.post(webhook_url, body: payload.to_json, headers: { 'Content-Type' => 'application/json' })
    # Manejar la respuesta del servicio de webhook según sea necesario
    Rails.logger.info "Webhook response: #{response.code} - #{response.body}"
  end
end
