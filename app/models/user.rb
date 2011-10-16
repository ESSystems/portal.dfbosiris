class User < ActiveRecord::Base
  set_table_name "referrers"
  
  belongs_to :person
  
  # Include default devise modules. Others available are:
  # :registerable, :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :username
  
  validates :username, :presence => true
  validates :username, :uniqueness => {:case_sensitive => false}
  validates :username, :length => {:minimum => 6}
end
