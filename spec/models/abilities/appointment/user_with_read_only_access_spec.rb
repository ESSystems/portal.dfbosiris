require 'spec_helper'

describe Ability do
  let(:appointment) { create(:appointment, :referral => referral) }
  let(:referral) { create(:referral) }
  let(:user) { create(:user, :read_only_access => true) }

  before do
    @ability = Ability.new(user)
  end

  it {@ability.should_not be_able_to(:confirm_appointment, appointment)}

  it {@ability.should_not be_able_to(:calendar_data, appointment)}

  it {@ability.should_not be_able_to(:calendar_update_date, appointment)}
end
