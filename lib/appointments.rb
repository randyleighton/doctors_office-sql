class Appointment

attr_reader :date, :cost, :doctor_id, :patient_id, :id

  def initialize(attributes)
    @date = attributes[:date]
    @cost = attributes[:cost].to_i
    @doctor_id = attributes[:doctor_id].to_i
    @patient_id = attributes[:patient_id].to_i
    @id = attributes[:id].to_i
    @appointments
  end

  def self.all
    @appointments = []
    results = DB.exec("SELECT * FROM appointments;")
    results.each  do |result|
      @appointments << Appointment.new({:date => result['date'],
                                        :cost => result['cost'],
                                        :patient_id => result['patient_id'],
                                        :doctor_id =>result['doctor_id'],
                                        :id => result['id']})
    end
    @appointments
  end

  def save
    result = DB.exec("INSERT INTO appointments (date, cost, patient_id,   doctor_id) VALUES ('#{@date}', '#{@cost}','#{@patient_id}','#{@doctor_id}') RETURNING id;")
    @id = result.first['id'].to_i
    @id
  end

  def ==(another_appointment)
    self.id == another_appointment.id && self.date == another_appointment.date
  end

end
