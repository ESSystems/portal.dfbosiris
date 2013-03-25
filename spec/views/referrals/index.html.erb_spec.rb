require 'spec_helper'

describe "referrals/index.html.erb" do

  include Devise::TestHelpers

  describe "show referral information" do

    context "when the user has all referrals tracking rights" do

    end

    context "when user has initiated_and_assigned referrals tracking rights" do

      before do
        login_user(:track_referrals => "initiated_and_assigned")
      end

      context "when the user created a referral" do
        before do
          @referral = create(:referral, :referrer => @logged_in_user)
          assign(:referrals, [@referral])

          visit referrals_path
        end

        it "sees the referral state"

        it "should show case reference number" do
          page.should have_content(@referral.case_reference_number)
        end

        it "should show patients full name" do
          page.should have_content(@referral.person.full_name)
        end

        it "should show only 150 characters of case nature" do
          page.should have_content(@referral.short_case_nature)
        end

        it "shouldn't show full case nature if it's longer that 150 characters" do
          page.should_not have_content(@referral.case_nature)
        end

        it "should show referral reason" do
          page.should have_content(@referral.referral_reason.reason)
        end

        it "shows the referral" do
          page.should have_link("View", :href => referral_path(@referral))
        end

        it "edits the referral" do
          page.should have_link("Edit", :href => edit_referral_path(@referral))
        end
      end

      context "when the referral has appointments" do
        before do
          @referral = create(:referral, :referrer => @logged_in_user, :appointments => [create(:appointment)])
          assign(:referrals, [@referral])
          visit referrals_path
        end

        it "cancels the referral" do
          pending "is there something wrong with the conditions?"
          page.should have_link("Cancel", :href => cancel_referral_path(@referral))
        end

        it "doesn't delete the referral" do
          pending "is there something wrong with the conditions?"
          page.should_not have_link("Delete", :href => referral_path(@referral), :method => :delete)
        end
      end

      context "when the referral doesn't have appointments" do
        before do
          @referral = create(:referral, :referrer => @logged_in_user, :appointments => [])
          assign(:referrals, [@referral])
          visit referrals_path
        end

        it "doesn't cancel the referral" do
          page.should_not have_link("Cancel", :href => cancel_referral_path(@referral))
        end

        it "deletes the referral" do
          page.should have_selector("//a[@data-method='delete' and @href='#{referral_path(@referral)}']", :text => "Delete")
        end
      end

      context "when the user didn't create a referral and is not a follower of a referral" do
        before do
          @referral = create(:referral)
          assign(:referrals, [@referral])

          visit referrals_path
        end

        it "doesn't see the referral state"

        it "doesn't show the referral" do
          page.should_not have_link("View", :href => referral_path(@referral))
        end

        it "doesn't edit the referral" do
          page.should_not have_link("Edit", :href => edit_referral_path(@referral))
        end

        it "doesn't cancel the referral" do
          page.should_not have_link("Cancel", :href => cancel_referral_path(@referral))
        end
      end

      context "when the user is a follower of a referral" do
        before do
          @referral = create(:referral, :followers => [@logged_in_user])
          assign(:referrals, [@referral])

          visit referrals_path
        end

        it "sees the referral state"

        it "shows referrals" do
          page.should have_link("View", :href => referral_path(@referral))
        end

        it "doesn't edit the referral" do
          page.should_not have_link("Edit", :href => edit_referral_path(@referral))
        end

        it "doesn't cancel the referral" do
          page.should_not have_link("Cancel", :href => cancel_referral_path(@referral))
        end
      end
    end
  end

end
