require 'spec_helper'

describe Ability do
  # let(:person) { create(:person) }
  let(:user) { create(:user, :read_only_access => true) }

  before do
    @ability = Ability.new(user)
  end

  it {@ability.should_not be_able_to(:create, Person.new)}

  it {@ability.should be_able_to(:index, Person.new)}

  it {@ability.should_not be_able_to(:new, Person.new)}

  shared_examples 'can not make person changes' do
    it {@ability.should_not be_able_to(:destroy, person)}

    it {@ability.should_not be_able_to(:edit, person)}

    it {@ability.should be_able_to(:show, person)}

    it {@ability.should_not be_able_to(:update, person)}
  end

  context 'User created the person' do
    it_behaves_like 'can not make person changes' do
      let(:person) {create(:person)}

      before do
        person.stub(:referrer).and_return user
      end
    end
  end

  context 'User did not create the person' do
    it_behaves_like 'can not make person changes' do
      let(:person) {create(:person)}
    end
  end
end
