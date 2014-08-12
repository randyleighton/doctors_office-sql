require 'pry'

class Insurance

  attr_reader :company, :id

  def initialize(attributes)
    @company = attributes[:company]
    @id
  end

  def self.all
    @companies = []
    results = DB.exec("SELECT * FROM insurance")
    results.each do |result|
      @companies << Insurance.new({:company => result['company']})
    end
    @companies
  end

  def save
    results = DB.exec("INSERT INTO insurance (company) VALUES ('#{@company}') RETURNING id;")
    @id = results.first['id'].to_i
    @id
  end

  def ==(another_insurance)
    self.company == another_insurance.company
  end

  def doctors_list
    @doctors_list = []
    results = DB.exec("SELECT * FROM doctors WHERE insurance_id = '#{self.id}';")
    results.each do |result|
      @doctors_list << Doctor.new({:name => result['name'],
                              :insurance_id => result['insurance_id'].to_i})
    end
    @doctors_list
  end
end
