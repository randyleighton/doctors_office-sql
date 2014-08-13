require 'pry'

class Specialty

  attr_reader :type, :id

  def initialize(attributes)
    @type = attributes[:type]
  end

  def self.all
    @specialties = []
    results = DB.exec("SELECT * FROM specialties;")
    results.each do |result|
      @specialties << Specialty.new(:type => result['type'])
    end
    @specialties
  end

  def doctors_list
    @doctors_list = []
    results = DB.exec("SELECT * FROM doctors WHERE specialty_id = '#{self.id}';")
    results.each do |result|
      @doctors_list << Doctor.new({:name => result['name'],
                                   :specialty_id => result['specialty_id'].to_i })
    end
    @doctors_list
  end

  def save
    results = DB.exec("INSERT INTO specialties (type) VALUES ('#{@type}') RETURNING id;")
    @id=results.first['id'].to_i
    @id
  end

  def ==(another_specialty)
    self.type == another_specialty.type
  end

  def delete
    DB.exec("DELETE FROM specialty WHERE id = '#{self.id}")
    DB.exec("DELETE FROM doctors WHERE specialty_id = '#{self.id}';")
    DB.exec("DELETE FROM patients WHERE doctor_id = '#{self.id}';")
  end
end
