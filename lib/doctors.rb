class Doctor

  attr_reader :name, :specialty_id, :id

  def initialize(attributes)
    @name = attributes[:name]
    @specialty_id = attributes[:specialty_id]
    @id
  end


  def self.all
    results = DB.exec("SELECT * FROM doctors;")
    @doctors = []
    results.each do |result|
      @doctors << Doctor.new({:name => result['name'], :specialty_id => result['specialty_id'].to_i})
    end
    @doctors
  end

  def save
    results = DB.exec("INSERT INTO doctors (name, specialty_id) VALUES ('#{@name}', '#{@specialty_id}') RETURNING id;")
    @id = results.first['id'].to_i
    @id
  end

  def ==(another_doctor)
    self.name == another_doctor.name && self.specialty_id == another_doctor.specialty_id
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
