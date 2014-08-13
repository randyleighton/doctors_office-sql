require 'spec_helper'

describe Patient do
  it "initializes an instance of Patient" do
    patient1 = Patient.new({:name => "John Doe", :birthdate => "2001-01-01"})
    expect(patient1).to be_an_instance_of Patient
  end
  it "returns the name and birthdate of the patient" do
    patient1 = Patient.new({:name => "John Doe", :birthdate => "2001-01-01"})
    expect(patient1.name).to eq "John Doe"
    expect(patient1.birthdate).to eq "2001-01-01"
  end
  it "starts with no patients" do
    expect(Patient.all).to eq []
  end
  it "saves the patients to the database" do
    patient1 = Patient.new({:name => "John Doe", :birthdate => "2001-01-01"})
    patient1.save
    expect(Patient.all).to eq [patient1]
  end
  it "is the same object if name and birthdate match" do
    patient1 = Patient.new({:name => "John Doe", :birthdate => "2001-01-01"})
    patient1.save
    patient2 = Patient.new({:name => "John Doe", :birthdate => "2001-01-01"})
    patient2.save
    expect(patient1).to eq patient2
  end
  it 'deletes a patient' do
    patient1 = Patient.new({:name => "John Doe", :birthdate => "2001-01-01",
                            :doctor_id => 1})
    patient2 = Patient.new({:name => "John Doe", :birthdate => "2001-01-01",
                            :doctor_id => 1})
    patient1.save
    patient2.save
    patient1.delete
    expect(Patient.all).to eq [patient2]
  end

  it 'adds/update a doctor for a patient' do
    patient1 = Patient.new({:name => "John Doe", :birthdate => "2001-01-01", :doctor_id => 2})
    patient1.save
    doctor1 = Doctor.new({:name => "Ralph Winston"})
    doctor1.save
    patient1.add_doctor(doctor1.id)
    expect(patient1.doctor_id).to eq doctor1.id
  end
end
