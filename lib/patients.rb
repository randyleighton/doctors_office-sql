class Patient

  attr_reader :name, :birthdate, :doctor_id, :id

  def initialize(attributes)
    @name = attributes[:name]
    @birthdate = attributes[:birthdate]
    @doctor_id = attributes[:doctor_id]
  end

  def self.all
    @patients = []
    results = DB.exec("SELECT * FROM patients;")
    results.each do |result|
      @patients << Patient.new({:name => result['name'], :birthdate => result['birthdate'],
                                :doctor_id =>result['doctor_id']})
    end
    @patients
  end

  def save
    results = DB.exec("INSERT INTO patients (name, birthdate, doctor_id) VALUES ('#{@name}', '#{@birthdate}',
              '#{@doctor_id}') RETURNING id;")
    @id = results.first['id'].to_i
    @id
  end

  def delete
    DB.exec("DELETE FROM patients WHERE id = '#{self.id}';")
  end

  def ==(another_patient)
    self.name == another_patient.name && self.birthdate == another_patient.birthdate
  end

  def add_doctor(doc_id)
    DB.exec("INSERT INTO patients (doctor_id) VALUES('#{doc_id}');")
    @doctor_id = doc_id
  end
end
