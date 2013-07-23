require 'spec_helper'

describe Ability do
  let(:user) { create(:user, :read_only_access => true) }

  before do
    @ability = Ability.new(user)
    @another_users_referral = create(:referral)
    @own_referral = create(:referral, :referrer => user)
  end

  it {@ability.should_not be_able_to(:create, Referral.new)}

  it {@ability.should_not be_able_to(:edit, Referral.new)}

  it {@ability.should be_able_to(:index, Referral)}

  it {@ability.should_not be_able_to(:new, Referral.new)}

  shared_examples 'can not make referral changes' do
    it {@ability.should_not be_able_to(:accept_declination_and_close, referral)}

    it {@ability.should_not be_able_to(:cancel, referral)}

    it {@ability.should_not be_able_to(:destroy, referral)}

    it {@ability.should be_able_to(:show, referral)}

    it {@ability.should_not be_able_to(:update, referral)}
  end

  context 'User created the referral' do
    it_behaves_like 'can not make referral changes' do
      let(:referral) {@own_referral}
    end
  end

  context 'User did not create the referral' do
    it_behaves_like 'can not make referral changes' do
      let(:referral) {@another_users_referral}
    end
  end
end
