require 'spec_helper'

describe Ability do

  let(:referral) { create(:referral) }

  describe "for authenticated user" do
    
    context "when the user has all referrals tracking rights" do
      let(:user) { create(:user, :track_referrals => "all") }

      before do
        @ability = Ability.new(user)
      end

      context "when public referral" do
        it "shows the referral" do
          @ability.should be_able_to(:show, referral)
        end
      
        it "edits the referral" do
          @ability.should be_able_to(:edit, referral)
        end
      
        it "updates the referral" do
          @ability.should be_able_to(:update, referral)
        end
        
        it "cancels the referral" do
          @ability.should be_able_to(:cancel, referral)
        end
      end

      context "when private referral" do
        before do
          referral.private = true
        end

        context "when own referral" do
          before do
            referral.referrer = user
          end

          it "can show the referral" do
            @ability.should be_able_to(:show, referral)
          end
        
          it "can edit the referral" do
            @ability.should be_able_to(:edit, referral)
          end
        
          it "can update the referral" do
            @ability.should be_able_to(:update, referral)
          end
          
          it "can cancel the referral" do
            @ability.should be_able_to(:cancel, referral)
          end
        end

        context "when other's referral" do
          it "doesn't show the referral" do
            @ability.should_not be_able_to(:show, referral)
          end
        
          it "doesn't edit the referral" do
            @ability.should_not be_able_to(:edit, referral)
          end
        
          it "doesn't update the referral" do
            @ability.should_not be_able_to(:update, referral)
          end
          
          it "doesn't cancel the referral" do
            @ability.should_not be_able_to(:cancel, referral)
          end
        end
      end
    end
    
    context "when the user has initiated_and_assigned referrals tracking rights" do
      let(:user) { create(:user, :track_referrals => "initiated_and_assigned") }

      before do
        @ability = Ability.new(user)
      end
      
      it "creates referrals" do
        @ability.should be_able_to(:create, referral)
      end

      it "views index" do
        @ability.should be_able_to(:index, referral)
      end

      context "when the user created a referral" do
        before :all do
          referral.referrer = user
        end
        
        it "shows the referral" do
          @ability.should be_able_to(:show, referral)
        end
      
        it "edits the referral" do
          @ability.should be_able_to(:edit, referral)
        end
      
        it "updates the referral" do
          @ability.should be_able_to(:update, referral)
        end
        
        it "cancels the referral" do
          @ability.should be_able_to(:cancel, referral)
        end
      end
      
      context "when the user didn't create a referral and is not a follower of a referral" do
        it "doesn't show the referral" do
          @ability.should_not be_able_to(:show, referral)
        end

        it "doesn't edit the referral" do
          @ability.should_not be_able_to(:edit, referral)
        end
        
        it "doesn't update the referral" do
          @ability.should_not be_able_to(:update, referral)
        end

        it "doesn't cancel the referral" do
          @ability.should_not be_able_to(:cancel, referral)
        end
      end
      
      context "when the user is a follower of a referral" do
        before :all do
          referral.followers = [user]
        end

        it "shows referrals" do
          @ability.should be_able_to(:show, referral)
        end
        
        it "doesn't edit the referral" do
          @ability.should_not be_able_to(:edit, referral)
        end
        
        it "doesn't update the referral" do
          @ability.should_not be_able_to(:update, referral)
        end

        it "doesn't cancel the referral" do
          @ability.should_not be_able_to(:cancel, referral)
        end
      end
      
    end

  end
end
