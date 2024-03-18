# app/queries/get_all_students_query.rb
class GetAllStudentsQuery
    def call
      ReadOnlyStudent.all
    end
  end
  