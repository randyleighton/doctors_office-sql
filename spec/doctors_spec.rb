require 'spec_helper'

describe Doctor do
  it "initializes the instance of the doctor's class" do
    doctor_1 = Doctor.new({:name => "Ralph Winston", :specialty_id => 1})
    expect(doctor_1).to be_an_instance_of Doctor
  end
  it "returns the name and specialty of the doctor" do
    doctor_1 = Doctor.new({:name => "Ralph Winston", :specialty_id => 1})
    expect(doctor_1.name).to eq 'Ralph Winston'
    expect(doctor_1.specialty_id).to eq 1
  end
  it "starts with no doctors" do
    expect(Doctor.all). to eq []
  end
  it "allows you to save multiple doctors" do
    doctor1 = Doctor.new({:name => "Ralph Winston", :specialty_id => 1})
    doctor2 = Doctor.new({:name => "Jon Jones", :specialty_id => 2})
    doctor1.save
    doctor2.save
    expect(Doctor.all).to eq [doctor1, doctor2]
  end
  it "is the same object if the name and specialty are the same" do
    doctor1 = Doctor.new({:name => "Ralph Winston", :specialty_id => 1})
    doctor2 = Doctor.new({:name => "Ralph Winston", :specialty_id => 1})
    doctor1.save
    doctor2.save
    expect(doctor1).to eq doctor2
  end
  it "allows you to assign a patient to a doctor" do
    doctor1 = Doctor.new({:name => "Ralph Winston", :specialty_id => 1})
    doctor1.save
    patient1 = Patient.new({:name => "John Doe", :birthdate => "2001-01-01",
                            :doctor_id => doctor1.id})
    patient1.save
    expect(doctor1.patient_list).to eq [patient1]
  end

  it "deletes a doctor and all thier patients" do
    doctor1 = Doctor.new({:name => "Ralph Winston", :specialty_id => 1})
    doctor2 = Doctor.new({:name => "Ralph Winston", :specialty_id => 1})
    doctor1.save
    doctor2.save
    patient1 = Patient.new({:name => "John Doe", :birthdate => "2001-01-01",
                            :doctor_id => doctor1.id})
    patient2 = Patient.new({:name => "John Doe", :birthdate => "2001-01-01",
                            :doctor_id => doctor2.id})
    patient1.save
    patient2.save
    doctor1.delete
    expect(Doctor.all).to eq [doctor2]
    expect(Patient.all).to eq [patient2]
  end

  it 'adds an insurance company to a doctor'  do
    insurance_company1 = Insurance.new({:company => "Aflac Cross"})
    insurance_company1.save
    doctor1 = Doctor.new({:name => "Ralph Winston", :insurance_id => insurance_company1.id})
    doctor1.save
    insurance_company2 = Insurance.new({:company => "Red Shield"})
    insurance_company2.save
    doctor1.add_insurance(insurance_company2.id)
    expect(doctor1.insurance_id).to eq insurance_company2.id
  end



end
