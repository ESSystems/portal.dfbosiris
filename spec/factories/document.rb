include ActionDispatch::TestProcess

FactoryGirl.define do
	factory :document do
		document { fixture_file_upload(Rails.root.join("spec/support/files/beans.jpg"), 'image/jpeg') }
		document_content_type "image/jpeg"
		document_fingerprint "387efeb850df115915c74452c4c74rey"
	end
end