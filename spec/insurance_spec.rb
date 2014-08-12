require 'spec_helper'

describe Insurance do
  it 'creates an instance of Insurance and returns its name' do
    test_insurance = Insurance.new({:company => "Shield Net"})
    expect(test_insurance).to be_an_instance_of Insurance
    expect(test_insurance.company).to eq "Shield Net"
  end

  it 'starts with no companies' do
    expect(Insurance.all).to eq []
  end

  it 'adds and saves multiples insurance companies' do
    insurance_company1 = Insurance.new({:company => "Shield Net"})
    insurance_company2 = Insurance.new({:company => "Aflac Cross"})
    insurance_company1.save
    insurance_company2.save
    expect(Insurance.all).to eq [insurance_company1, insurance_company2]
  end

  it 'makes two insurance objects the same if company is same' do
    insurance_company1 = Insurance.new({:company => "Aflac Cross"})
    insurance_company2 = Insurance.new({:company => "Aflac Cross"})
    insurance_company1.save
    insurance_company2.save
    expect(insurance_company1).to eq insurance_company2
  end

end
