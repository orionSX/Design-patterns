require_relative '../../../DB/DB_connection.rb'
class StudentsListDB
  def initialize
  @client = DatabaseConnection.instance
  end

  def get_student(id) 
    result = @client.query("SELECT * FROM student WHERE id = #{id}").first
    Student.new(**result.transform_keys(&:to_sym)) if result
  end

  def get_k_n_student_short_list(k, n,data_list=nil,filters=[])
    offset = (k - 1) * n
    query = "SELECT * FROM student LIMIT #{n} OFFSET #{offset}"
    results = @client.query(query).map do |row|
     Student.new(**row.transform_keys(&:to_sym))
    end
    filter_sequence=FilterDecorator.new(filters)
    filtered_students=filter_sequence.apply(results)
    results=filtered_students.map do |st|
      StudentShort.new(st)
    end
    
    DataListStudentShort.new(results)

  end

  def add_student(student)

    results = @client.query("SELECT * FROM student")
    results.each do |st|
      Student.new(**st.transform_keys(&:to_sym))
      if !st.phone.nil? && st.phone==student.phone || !st.tg.nil? && st.tg==student.tg || !st.email.nil? && st.email==student.email || !st.git.nil? && st.git==student.git
        raise "Contact exists"
      end
    end
    query = <<-SQL
      INSERT INTO student (surname, first_name, last_name, date_of_birth, tg, email, git,phone)
VALUES ('#{student.surname}', '#{student.first_name}', '#{student.last_name}', '#{student.date_of_birth}', '#{student.tg}', '#{student.email}', '#{student.git}','#{student.phone}')
    SQL
    @client.query(query)
    @client.last_id
  end

  def update_student(id, student)
    results = @client.query("SELECT * FROM student")
    results.each do |st|
      Student.new(**st.transform_keys(&:to_sym))
      if !st.phone.nil? && st.phone==student.phone || !st.tg.nil? && st.tg==student.tg || !st.email.nil? && st.email==student.email || !st.git.nil? && st.git==student.git
        raise "Contact exists"
      end
    end
    query = <<-SQL
      UPDATE student
      SET surname='#{student.surname}', first_name='#{student.first_name}', last_name='#{student.last_name}',
    date_of_birth='#{student.date_of_birth}', tg='#{student.tg}', email='#{student.email}', git='#{student.git}',phone='#{student.phone}'
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
