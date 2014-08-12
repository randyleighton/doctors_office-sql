class Doctor

  attr_reader :name, :specialty

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
    DB.exec("INSERT INTO doctors (name, specialty) VALUES ('#{@name}', '#{@specialty}');")
  end

  def ==(another_doctor)
    self.name == another_doctor.name && self.specialty == another_doctor.specialty
  end

  def patients

  end


end
