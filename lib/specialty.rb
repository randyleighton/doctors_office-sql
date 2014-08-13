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
    #deleting the specialty and the doctors with that specialty
    #also deleting the patients of those doctors
        @doctors_with_this_specialty = []
    DB.exec("DELETE FROM specialties WHERE id = '#{self.id}';")
    results = DB.exec("SELECT * FROM doctors where specialty_id = '#{self.id}';")
    results.each do |result|
      @doctors_with_this_specialty << result['id'].to_i
    end
    @doctors_with_this_specialty.each do |doc_id|
      DB.exec("DELETE FROM patients WHERE doctor_id = '#{doc_id}';")
      DB.exec("DELETE FROM doctors WHERE id = '#{doc_id}';")
    end
  end
end
