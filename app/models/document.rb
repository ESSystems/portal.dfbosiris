class Document < ActiveRecord::Base
  belongs_to :attachable, :polymorphic => true

  has_attached_file :document,
    :url => '/documents/:id/download'

  def is_creator? user_id
  	r = Referral.joins(:documents).where("documents.id = ? and referrals.referrer_id = ?", id, user_id)
  	return r.empty? ? false : true
  end

  def is_follower? user_id
  	r = Referral.joins(:documents).joins(:followers).where("documents.id = ? and referrals_followers.referrer_id = ?", id, user_id)
  	return r.empty? ? false : true
  end

  def is_private?
  	r = Referral.joins(:documents).where("documents.id = ?", id)
  	return r.empty? || !r.first.private? ? false : true
  end

  def osiris_url
    "http://#{OSIRIS_SERVER_NAME}/upload/#{self.class.name.downcase.pluralize}/#{self.document_fingerprint}/#{self.document_file_name}"
  end
end
