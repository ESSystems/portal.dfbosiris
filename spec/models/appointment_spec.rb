require 'spec_helper'

describe Appointment do
  let(:appointment) do
    Factory.create(:appointment)
  end
  
  describe "display date" do
    it "should show appointment date" do
      appointment.display_date.should include("#{appointment.from_date.to_date}")
    end
    
    it "should show appointment interval" do
      appointment.display_date.should include("#{appointment.from_date.to_s(:hours_and_minutes)} to #{appointment.to_date.to_s(:hours_and_minutes)}")
    end
    
    it "should show appointment date and appoinment interval" do
      appointment.display_date.should eq("#{appointment.from_date.to_date} from #{appointment.from_date.to_s(:hours_and_minutes)} to #{appointment.to_date.to_s(:hours_and_minutes)}")
    end
  end
end
