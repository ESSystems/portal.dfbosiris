require 'spec_helper'

describe Appointment do
  let(:appointment) do
    Factory(:appointment)
  end
      
  before(:each) do
    @appointment = appointment
  end
end
