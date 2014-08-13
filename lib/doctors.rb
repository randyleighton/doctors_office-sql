class Doctor

  attr_reader :name, :specialty_id, :id, :insurance_id

  def initialize(attributes)
    @name = attributes[:name]
    @specialty_id = attributes[:specialty_id]
    @insurance_id = attributes[:insurance_id]
    @id
  end


  def self.all
    results = DB.exec("SELECT * FROM doctors;")
    @doctors = []
    results.each do |result|
      @doctors << Doctor.new({:name => result['name'], :specialty_id => result['specialty_id'].to_i,
                              :insurance_id => result['insurance_id']})
    end
    @doctors
  end

  def save
    results = DB.exec("INSERT INTO doctors (name, specialty_id, insurance_id) VALUES ('#{@name}', '#{@specialty_id}',
                      '#{@insurance_id}') RETURNING id;")
    @id = results.first['id'].to_i
    @id
  end

  def delete
    DB.exec("DELETE FROM doctors WHERE id = '#{self.id}';")
    DB.exec("DELETE FROM patients WHERE doctor_id = '#{self.id}';")
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

  def add_insurance(ins_id)
    DB.exec("INSERT INTO doctors (insurance_id) VALUES ('#{ins_id}');")
    @insurance_id = ins_id
  end
end
