Factory.define :user do |u|
  u.association :person
  u.username { Forgery(:basic).text(:at_least => 6) }
  u.email { Forgery(:internet).email_address }
  u.password Forgery(:basic).password(:at_least => 6)
  u.track_referrals "all"
end