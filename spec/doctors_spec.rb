require 'spec_helper'

describe Doctor do
  it "initializes the instance of the doctor's class" do
    doctor_1 = Doctor.new({:name => "Ralph Winston", :specialty => "Pediatrician"})
    expect(doctor_1).to be_an_instance_of Doctor
  end
  it "returns the name and specialty of the doctor" do
    doctor_1 = Doctor.new({:name => "Ralph Winston", :specialty => "Pediatrician"})
    expect(doctor_1.name).to eq 'Ralph Winston'
    expect(doctor_1.specialty).to eq 'Pediatrician'
  end
  it "starts with no doctors" do
    expect(Doctor.all). to eq []
  end
  it "allows you to save multiple doctors" do
    doctor1 = Doctor.new({:name => "Ralph Winston", :specialty => "Pediatrician"})
    doctor2 = Doctor.new({:name => "Jon Jones", :specialty => "Family"})
    doctor1.save
    doctor2.save
    expect(Doctor.all).to eq [doctor1, doctor2]
  end
  it "is the same object if the name and specialty are the same" do
    doctor1 = Doctor.new({:name => "Ralph Winston", :specialty => "Pediatrician"})
    doctor2 = Doctor.new({:name => "Ralph Winston", :specialty => "Pediatrician"})
    doctor1.save
    doctor2.save
    expect(doctor1).to eq doctor2
  end
  it "allows you to assign a patient to a doctor" do
    doctor1 = Doctor.new({:name => "Ralph Winston", :specialty => "Pediatrician"})
    doctor1.save
    patient1 = Patient.new({:name => "John Doe", :birthdate => "2001-01-01"})
    patient1.save
    expect(doctor1.patients).to eq [patient1]
  end


end
