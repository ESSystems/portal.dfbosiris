class User < ActiveRecord::Base
  self.table_name = "referrers"

  REFERRALS_TRACKING = %w[all initiated_and_assigned]

  belongs_to :person
  belongs_to :organisation, :foreign_key => "client_id"

  # Include default devise modules. Others available are:
  # :registerable, :token_authenticatable, :encryptable, :confirmable, :lockable and :omniauthable
  devise :database_authenticatable, :recoverable, :trackable, :validatable, :timeoutable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :username, :track_referrals

  validates :username, :presence => true
  validates :username, :uniqueness => {:case_sensitive => false}
  validates :username, :length => {:minimum => 6}

  scope :find_by_full_name, lambda { |search|
    param = "%#{search}%"
    joins(:person).where("person.first_name LIKE ? OR person.last_name LIKE ?", param, param)
  }

  scope :users_in_organisation, lambda { |organisation_id|
    where("client_id" => organisation_id)
  }

  def self.current
    Thread.current[:user]
  end

  def self.current=(user)
    Thread.current[:user] = user
  end

  def display_name
    person.full_name
  end

  def unread_notifications
    number = 0

    result = connection.execute "SELECT COUNT(*) FROM notifications n USE INDEX(read_target_id_index) WHERE n.read = 0 AND n.target_id = #{self.id}"
    result.each{ |res|
      number = res[0] if res != nil
    }

    number
  end
end
