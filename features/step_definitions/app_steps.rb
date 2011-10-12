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

When /^I choose today in the "([^"]*)" datepicker$/ do |id|
  page.execute_script %Q{ $('##{id}').trigger("focus") }
  page.execute_script %Q{ $('##{id}').trigger("keydown") }
  page.execute_script %Q{ $('##{id}').trigger("mouseenter").trigger("click"); }
  sleep 1
  page.execute_script %Q{ $('.ui-datepicker-today a').trigger("mouseenter").trigger("click") }
end

Then /^the "([^"]*)" field should contain today$/ do |field|
  Then %Q{the "#{field}" field should contain "#{Date.today.to_s}"}
end
