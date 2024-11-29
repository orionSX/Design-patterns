require_relative '../../../DB/DB_connection.rb'
class StudentsListDB
  def initialize
  @client = DatabaseConnection.instance
  end

  def get_student(id)
    result = @client.query("SELECT * FROM student WHERE id = #{id}").first
    Student.new(**result.transform_keys(&:to_sym)) if result
  end

  def get_k_n_student_short_list(k, n)
    offset = (k - 1) * n
    query = "SELECT * FROM student LIMIT #{n} OFFSET #{offset}"
    results = @client.query(query).map do |row|
      StudentShort.new(Student.new(**row.transform_keys(&:to_sym)))
    end
    DataListStudentShort.new(results)

  end

  def add_student(student)
    query = <<-SQL
      INSERT INTO student (surname, first_name, last_name, date_of_birth, tg, email, git,phone)
VALUES ('#{student.surname}', '#{student.first_name}', '#{student.last_name}', '#{student.date_of_birth}', '#{student.tg}', '#{student.email}', '#{student.git}','#{student.phone}')
    SQL
    @client.query(query)
    @client.last_id
  end

  def update_student(id, updated_student)
    query = <<-SQL
      UPDATE student
      SET surname='#{updated_student.surname}', first_name='#{updated_student.first_name}', last_name='#{updated_student.last_name}',
    date_of_birth='#{updated_student.date_of_birth}', tg='#{updated_student.tg}', email='#{updated_student.email}', git='#{updated_student.git}',phone='#{updated_student.phone}'
      WHERE id=#{id}
    SQL
    @client.query(query)
  end

  def delete_student(id)
    @client.query("DELETE FROM student WHERE id = #{id}")
  end

  def student_count
    @client.query('SELECT COUNT(*) AS count FROM student').first['count']
  end
end
