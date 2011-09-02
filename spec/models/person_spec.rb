require 'spec_helper'

describe Person do
  
  describe "full name" do
    let(:person) do
      Factory.build(:person, :first_name => "John", :last_name => "Doe")
    end
    
    it "should show first name and last name if no middle name" do
      person.middle_name = ""
      person.full_name.should eq("John Doe")
    end
    
    it "should not show middle name if it is nil" do
      person.middle_name = nil
      person.full_name.should eq("John Doe")
    end
    
    it "should not show first name if it is nil" do
      person.first_name = nil
      person.full_name.should eq("A. Doe")
    end
    
    it "should not show last name if it is nil" do
      person.last_name = nil
      person.full_name.should eq("John A.")
    end
    
    it "should show middle initial" do
      person.middle_name = "A"
      person.full_name.should eq("John A. Doe")
    end
    
    it "should show middle initial with one period" do
      person.middle_name = "A."
      person.full_name.should eq("John A. Doe")
    end
    
    it "should capitalize only the first letter" do
      person.first_name = "JOHN"
      person.last_name = "DOE"
      person.middle_name = "A."
      person.full_name.should eq("John A. Doe")
    end
  end

end
