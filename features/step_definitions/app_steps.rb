When /^I wait until "([^"]*)" is visible$/ do |selector|
  page.has_css?("#{selector}", :visible => true)
end

When /^(?:|I )select "([^"]*)" from selectmenu "([^"]*)"$/ do |value, field|
  click_on(value)
end

Then /^the field with id "([^"]*)" should contain "([^"]*)"$/ do |id, value|
  field = find(:xpath,%{//*[@type="hidden" and @id="#{id}"]})
  field_value = (field.tag_name == 'textarea') ? field.text : field.value
  if field_value.respond_to? :should
    field_value.should =~ /#{value}/
  else
    assert_match(/#{value}/, field_value)
  end
end