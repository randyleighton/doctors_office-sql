require 'spec_helper'

describe Doctor do
  it "initializes the instance of the doctor's class" do
    doctor_1 = Doctor.new({:name => "Ralph Winston", :specialty => "Pediatrician"})
    expect(doctor_1).to be_an_instance_of Doctor
  end
end


