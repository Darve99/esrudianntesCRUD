# app/commands/delete_student_command.rb
class DeleteStudentCommand
    def initialize(student_id)
      @student_id = student_id
    end
  
    def execute
      student = Student.find_by(id: @student_id)
      student.destroy if student
    end
  end
  