class Patient

  attr_reader :name, :birthdate, :doctor_id

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
    DB.exec("INSERT INTO patients (name, birthdate, doctor_id) VALUES ('#{@name}', '#{@birthdate}',
              '#{@doctor_id}');")
  end

  def ==(another_patient)
    self.name == another_patient.name && self.birthdate == another_patient.birthdate
  end

end
