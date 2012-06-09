require 'spec_helper'

describe Person do
  
  describe "scope autocomplete fields" do
    it "should get full name as value"
  end
  
  describe "get full name" do
    let(:person) do
      build(:person, :first_name => "John", :middle_name => "A", :last_name => "Doe")
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
  
  describe "set full name" do
    let(:person) do
      build(:person)
    end
    
    it "should set first name if assignment is composed of one word" do
      person.full_name = "David"
      person.first_name.should eq("David")
    end
    
    it "should set first name and last name if assignment is composed of two words" do
      person.full_name = "David Coperfield"
      person.first_name.should eq("David")
      person.last_name.should eq("Coperfield")
    end
    
    it "should assign middle name to nil if assignment is composed of two words" do
      person.full_name = "David Coperfield"
      person.middle_name.should eq(nil)
    end
    
    it "should set first name, middle name and last name if assignment is composed of three words" do
      person.full_name = "David S. Coperfield"
      person.first_name.should eq("David")
      person.middle_name.should eq("S.")
      person.last_name.should eq("Coperfield")
    end
  end

end
