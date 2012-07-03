class Document < ActiveRecord::Base

  ORIGIN = %w[osiris portal]

  before_save :default_values

  belongs_to :attachable, :polymorphic => true

  has_attached_file :document,
    :url => '/download/:id/:fingerprint/documents'

  def default_values
    self.origin ||= 'portal'
  end

  def from_osiris?
    self.origin == "osiris"
  end

  def from_portal?
    self.origin == "portal"
  end

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
    "http://#{OSIRIS_SERVER_NAME}/download/#{id}/#{document_fingerprint}/#{User.current.id}/documents"
  end

  def path
    document.path
  end
end
