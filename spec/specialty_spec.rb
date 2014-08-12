require 'pry'
require 'spec_helper'

describe Specialty do
  it "initializes a specialty with a type" do
    specialty1 = Specialty.new({:type => "Pediatrics"})
    expect(specialty1.type).to eq "Pediatrics"
    expect(specialty1).to be_an_instance_of Specialty
  end

  it "starts with no specialties" do
    expect(Specialty.all).to eq []
  end

  it 'saves multiple specialties' do
    specialty1 = Specialty.new({:type => "Pediatrics"})
    specialty2 = Specialty.new({:type => "Family"})
    specialty1.save
    specialty2.save
    expect(Specialty.all).to eq [specialty1, specialty2]
  end

  it "makes two types of objects equal to each other" do
    specialty1 = Specialty.new({:type => "Pediatrics"})
    specialty1.save
    specialty2 = Specialty.new({:type => "Pediatrics"})
    specialty2.save
    expect(specialty1).to eq specialty2
  end

  it "lists all the doctors who practice a particular specialty" do
    specialty1 = Specialty.new({:type => "Pediatrics"})
    specialty1.save
    doctor1 = Doctor.new({:name => "Ralph Winston", :specialty_id => specialty1.id})
    doctor1.save
    expect(specialty1.doctors_list).to eq [doctor1]
  end


end
