class ReferralReason < ActiveRecord::Base
  
  def to_s
    reason
  end
end
