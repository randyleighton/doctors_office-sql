require 'rspec'
require 'pg'
require 'pry'
require './lib/doctors'
require './lib/patients'
require './lib/specialty'

DB = PG.connect(:dbname => 'doctors_office')
RSpec.configure do |config|
  config.after(:each) do
    DB.exec("DELETE FROM doctors *;")
    DB.exec("DELETE FROM patients *;")
    DB.exec("DELETE FROM specialties *;")
  end
end
