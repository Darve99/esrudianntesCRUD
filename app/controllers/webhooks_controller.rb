# app/controllers/webhooks_controller.rb
class WebhooksController < ApplicationController
    skip_before_action :verify_authenticity_token 
  
    def handle
      event_type = params[:event_type]
      data = params[:data]
  
      case event_type
      when 'student_created'
        handle_student_created(data)
      when 'student_updated'
        handle_student_updated(data)
      when 'student_deleted'
        handle_student_deleted(data)
      else
        # Manejar otros tipos de eventos de webhook si es necesario
        head :ok
      end
    end
  
    private
  
    def handle_student_created(data)
      student = Student.new(name: data[:name], email: data[:email], age: data[:age])
      if student.save
        # Logica adicional si es necesario
        head :ok
      else
        head :unprocessable_entity
      end
    end
  
    def handle_student_updated(data)
      student = Student.find_by(id: data[:id])
      if student&.update(name: data[:name], email: data[:email], age: data[:age])
        # Logica adicional si es necesario
        head :ok
      else
        head :unprocessable_entity
      end
    end
  
    def handle_student_deleted(data)
      student = Student.find_by(id: data[:id])
      if student&.destroy
        # Logica adicional si es necesario
        head :ok
      else
        head :unprocessable_entity
      end
    end
  end
  