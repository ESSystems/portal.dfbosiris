require 'spec_helper'

# Structure
describe User do
  it { should have_db_column(:read_only_access).of_type(:boolean) }
end

describe User do

  describe "update email address" do
    it "should update User email with associated Person email on initialize"
  end

  describe "username constraints" do
    it "should be required"

    it "it's length should be greater than 6"

    it "should be unique"
  end

  describe "timeoutable" do
  	let(:user) { build(:user) }

  	it "uses timeout time 15 minutes" do
  		user.timeout_in.should eq(15.minutes)
  	end
  end
end
