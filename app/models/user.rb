class User < ActiveRecord::Base
  set_table_name "referrers"

  REFERRALS_TRACKING = %w[all initiated_and_assigned]

  belongs_to :person

  # Include default devise modules. Others available are:
  # :registerable, :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :username, :track_referrals

  validates :username, :presence => true
  validates :username, :uniqueness => {:case_sensitive => false}
  validates :username, :length => {:minimum => 6}

  scope :find_by_full_name, lambda { |search|
    param = "%#{search}%"
    joins(:person).where("person.first_name LIKE ? OR person.last_name LIKE ?", param, param)
  }

  def display_name
    person.full_name
  end
end
