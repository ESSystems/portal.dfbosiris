When /^I wait until "([^"]*)" is visible$/ do |selector|
  page.has_css?("#{selector}", :visible => true)
end

When /^(?:|I )select "([^"]*)" from selectmenu "([^"]*)"$/ do |value, field|
  click_on(value)
end
