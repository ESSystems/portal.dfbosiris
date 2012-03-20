Factory.define :referral_reason do |f|
  f.reason Forgery(:lorem_ipsum).words(6)
end