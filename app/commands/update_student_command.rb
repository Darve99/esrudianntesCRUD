class UpdateStudentCommand
  def initialize(student_id, student_params)
    raise ArgumentError, "Student ID cannot be nil" if student_id.nil?
    raise ArgumentError, "Student parameters cannot be nil" if student_params.nil?

    @student_id = student_id
    @student_params = student_params
  end

  def execute
  student = Student.find_by(id: @student_id)
  raise ActiveRecord::RecordNotFound, "Student not found with ID: #{@student_id}" if student.nil?

  student.update(@student_params.permit(:name, :email, :age))
end

end
# Path: app/commands/delete_student_command.rb