class ReferrerType < ActiveRecord::Base

  def self.inheritance_column
    nil
  end

  def to_s
    type
  end
end
