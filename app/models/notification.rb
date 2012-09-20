class Notification < ActiveRecord::Base

  default_scope order("created DESC")

  def after_find
    self.message = "fdsa"
  end

  def short_message
    m = message.slice(0..150)
    m << "..." if message.length > 150
    m
  end

  def self.associated_notifications target_model, target_id, limit = nil
    params = {
      :conditions => ["target_model = ? AND target_id = ?", target_model, target_id], :from => "#{quoted_table_name} USE INDEX(target_id_target_model_index)"
    }
    params[:limit] = limit unless limit.nil?
    all(params)
  end
end
