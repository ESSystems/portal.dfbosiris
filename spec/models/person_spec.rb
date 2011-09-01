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
    
    it "should show middle initial" do
      person.middle_name = "A"
      person.full_name.should eq("John A. Doe")
    end
    
    it "should show middle initial with one period" do
      person.middle_name = "A."
      person.full_name.should eq("John A. Doe")
    end
  end

end
