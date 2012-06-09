require 'spec_helper'

describe Appointment do
  describe "display date" do
    let(:appointment) do
      create(:appointment)
    end
  
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

  it "confirm"

  # TODO check steps definitions to test corectly the feature  
  describe "find overlapping dates" do
    let(:appointment) do
      create(:appointment, :diary_id => 20002, :from_date => Time.now - (60*60*24), :to_date => Time.now - (60*60*23))
    end
    
    let(:booked_appointment) do
      create(:appointment, :diary_id => 20002)
    end

    context "returns empty" do
      it "when start date is before booked start date and end date is after booked start date" do
        from_date = booked_appointment.from_date - (60 * 15)
        to_date = booked_appointment.from_date + (60 * 30)
        appointment.is_overlapping_another(from_date, to_date).should be_true
      end
      
      it "when start date is after booked start date and end date is after booked end date" do
        from_date = booked_appointment.from_date + (60 * 15)
        to_date = booked_appointment.to_date + (60 * 45)
        appointment.is_overlapping_another(from_date, to_date).should == true
      end
      
      it "when start date is after booked start date and end date is before booked end date" do
        from_date = booked_appointment.from_date + (60 * 15)
        to_date = booked_appointment.to_date - (60 * 15)
        appointment.is_overlapping_another(from_date, to_date).should == true
      end
      
      it "when start date is before booked start date and end date is after booked end date" do
        from_date = booked_appointment.from_date - (60 * 15)
        to_date = booked_appointment.to_date + (60 * 45)
        appointment.is_overlapping_another(from_date, to_date).should == true
      end
    end
    
  end
end
