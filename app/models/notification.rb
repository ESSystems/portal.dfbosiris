class Notification < ActiveRecord::Base
  
  scope :associated_notifications, lambda {|target_model, target_id|
    where("target_model = ? AND target_id = ?", target_model, target_id)
  }
  
  default_scope order("created DESC")
  
  def after_find
    self.message = "fdsa"
  end
  
  def short_message
    m = message.slice(0..100)
    m << "..." if message.length > 100
    m
  end
end
