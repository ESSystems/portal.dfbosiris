require 'spec_helper'

describe Ability do
  let(:referral) { create(:referral) }
  let(:user) { create(:user, :read_only_access => true) }

  before do
    @ability = Ability.new(user)
  end

  it {@ability.should_not be_able_to(:accept_declination_and_close, referral)}

  it {@ability.should_not be_able_to(:cancel, referral)}

  it {@ability.should_not be_able_to(:create, Referral.new)}

  it {@ability.should_not be_able_to(:destroy, referral)}

  it {@ability.should_not be_able_to(:edit, Referral.new)}

  it {@ability.should be_able_to(:index, referral)}

  it {@ability.should_not be_able_to(:new, referral)}

  it {@ability.should be_able_to(:show, referral)}

  it {@ability.should_not be_able_to(:update, referral)}
end
