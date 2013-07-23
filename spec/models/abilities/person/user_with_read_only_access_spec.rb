require 'spec_helper'

describe Ability do
  let(:person) { create(:person) }
  let(:user) { create(:user, :read_only_access => true) }

  before do
    @ability = Ability.new(user)
  end

  it {@ability.should_not be_able_to(:create, person)}

  it {@ability.should_not be_able_to(:destroy, person)}

  it {@ability.should_not be_able_to(:edit, person)}

  it {@ability.should be_able_to(:index, person)}

  it {@ability.should_not be_able_to(:new, person)}

  it {@ability.should be_able_to(:show, person)}

  it {@ability.should_not be_able_to(:update, person)}
end
