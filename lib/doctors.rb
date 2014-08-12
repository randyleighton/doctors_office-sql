class Doctor

  attr_reader :name, :specialty, :id

  def initialize(attributes)
    @name = attributes[:name]
    @specialty = attributes[:specialty]
  end


  def self.all
    results = DB.exec("SELECT * FROM doctors;")
    @doctors = []
    results.each do |result|
      @doctors << Doctor.new({:name => result['name'], :specialty => result['specialty']})
    end
    @doctors
  end

  def save
    results = DB.exec("INSERT INTO doctors (name, specialty) VALUES ('#{@name}', '#{@specialty}') RETURNING id;")
    @id = results.first['id'].to_i
    @id
  end

  def ==(another_doctor)
    self.name == another_doctor.name && self.specialty == another_doctor.specialty
  end

  def patient_list
    @patient_list = []
    results = DB.exec("SELECT * FROM patients WHERE doctor_id = '#{self.id}';")
    results.each do |result|
      @patient_list << Patient.new({:name => result['name'], :birthdate =>result['birthdate'],
                                    :doctor_id => result['doctor_id']})
    end
    @patient_list
  end


end
