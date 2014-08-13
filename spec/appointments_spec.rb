require 'spec_helper'
require 'pry'

describe Appointment do

  it 'initializes an appointment object and returns the characteristics' do
    new_appointment = Appointment.new({:date => '2014-10-10', :cost => 100,
                            :patient_id =>1, :doctor_id =>2})
    expect(new_appointment).to be_an_instance_of Appointment
  end

  it 'starts with no appointments' do
    expect(Appointment.all).to eq []
  end

  it 'allows you to add multiple appointments' do
    new_appointment1 = Appointment.new({:date => '2014-10-10', :cost => 100,
                                       :patient_id =>1, :doctor_id =>2})
    new_appointment2 = Appointment.new({:date => '2014-11-11', :cost => 110,
                                       :patient_id =>2, :doctor_id =>3})
    new_appointment1.save
    new_appointment2.save
    expect(Appointment.all).to eq [new_appointment1, new_appointment2]
  end

  it 'sets an object with the same attributes equal to one another' do
    new_appointment1 = Appointment.new({:date => '2014-10-10', :cost => 100,
                                       :patient_id =>1, :doctor_id =>2})
    new_appointment1.save
    expect(Appointment.all).to eq [new_appointment1]
  end

end
