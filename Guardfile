notification :growl

guard 'spork', :rspec_env => { 'RAILS_ENV' => 'test' }, :wait => 60 do
  watch('config/application.rb')
  watch('config/environment.rb')
  watch(%r{^config/environments/.+\.rb$})
  watch(%r{^config/initializers/.+\.rb$})
  watch('Gemfile')
  watch('Gemfile.lock')
  watch('spec/spec_helper.rb') { :rspec }
end

guard 'rspec', :cli => '-c --drb', :all_on_start => false, :all_after_pass => false, :focus_on_failed => true do
  watch(%r{^spec/.+_spec\.rb})
  watch(%r{^lib/(.+)\.rb})                            { |m| "spec/lib/#{m[1]}_spec.rb" }
  watch('spec/spec_helper.rb')                        { "spec" }

  # Rails example
  watch('spec/spec_helper.rb')                        { "spec" }
  watch('config/routes.rb')                           { "spec/routing" }
  watch('app/controllers/application_controller.rb')  { "spec/controllers" }
  watch(%r{^spec/.+_spec\.rb})
  watch(%r{^app/(.+)\.rb})                            { |m| "spec/#{m[1]}_spec.rb" }
  watch(%r{^lib/(.+)\.rb})                            { |m| "spec/lib/#{m[1]}_spec.rb" }
  watch(%r{^app/controllers/(.+)_(controller)\.rb})   { |m| ["spec/routing/#{m[1]}_routing_spec.rb", "spec/#{m[2]}s/#{m[1]}_#{m[2]}_spec.rb", "spec/acceptance/#{m[1]}_spec.rb"] }
  watch(%r{^app/models/(.+)\.rb$})                    {|m| "spec/models/#{m[1]}_spec.rb" }
  watch(%r{^app/views/(.+)/})                         { |m| "spec/requests/#{m[1]}_spec.rb" }
end
