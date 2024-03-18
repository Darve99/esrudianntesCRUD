class CreateStudentCommand
  def initialize(student_params)
    @student_params = student_params
  end

  def execute
    student = Student.new(@student_params)
    if student.valid?
      student.save
    else
      false
    end
  end
end
# Path: app/commands/delete_student_command.rb