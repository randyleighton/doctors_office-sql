class Appointment

attr_reader :date, :cost, :doctor_id, :patient_id

  def initialize(attributes)
    @date = attributes[:date]
    @cost = attributes[:cost]
    @doctor_id = attributes[:doctor_id]
    @patient_id = attributes[:patient_id]
  end

  def self.all
    @appointments = []
    results = DB.exec("SELECT * FROM appointments;")
    results.each  do |result|
      @appointments << Appointment.new({:date => result['date'],
                                        :cost => result['cost'],
                                        :patient_id => result['patient_id'],
                                        :doctor_id =>result['doctor_id']})
    end
    @appointments
  end

  def save
    DB.exec("INSERT INTO appointments (date, cost, patient_id, doctor_id)
             VALUES ('#{@date}', '#{@cost}','#{@patient_id}','#{@doctor_id}');")
  end

end
