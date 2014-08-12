class Patient

  attr_reader :name, :birthdate

  def initialize(attributes)
    @name = attributes[:name]
    @birthdate = attributes[:birthdate]
  end

  def self.all
    @patients = []
    results = DB.exec("SELECT * FROM patients;")
    results.each do |result|
      @patients << Patient.new({:name => result['name'], :birthdate => result['birthdate']})
    end
    @patients
  end

  def save
    DB.exec("INSERT INTO patients (name, birthdate) VALUES ('#{@name}', '#{@birthdate}');")
  end

  def ==(another_patient)
    self.name == another_patient.name && self.birthdate == another_patient.birthdate
  end

end
