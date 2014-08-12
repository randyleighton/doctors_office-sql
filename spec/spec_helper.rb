require 'rspec'
require 'pg'
require 'pry'
require './lib/doctors'
require './lib/patients'

DB = PG.connect(:dbname => 'doctors_office')
RSpec.configure do |config|
  config.after(:each) do
    DB.exec("DELETE FROM doctors *;")
    DB.exec("DELETE FROM patients *;")
  end
end
