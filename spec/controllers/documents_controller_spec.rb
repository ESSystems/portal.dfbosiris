require 'spec_helper'

describe DocumentsController do
	let(:document) { mock_model(Document, :document => fixture_file_upload(Rails.root.join("spec/support/files/beans.jpg"), 'image/jpeg'), :document_content_type => "image/jpeg", :document_fingerprint => "387efeb850df115915c74452c4c74rey") }

	describe "download" do
		it "calls find_by_document_fingerprint on Document" do
			Document.should_receive(:find_by_id_and_document_fingerprint)
        	get :download, :id => document.id, :fingerprint => document.document_fingerprint
		end

		context "when document is not found" do
			before do
				Document.stub!(:find_by_id_and_document_fingerprint).with("#{document.id}", "#{document.document_fingerprint}").and_return(nil)
			end

			it "redirects to referrals index page" do
				get :download, :id => document.id, :fingerprint => document.document_fingerprint
    			response.should redirect_to(:controller => 'referrals', :action => 'index')
			end

			it "sets a flash[:error] message" do
		    	get :download, :id => document.id, :fingerprint => document.document_fingerprint
				flash[:error].should eq("There was a problem with the document you requested. The document either does not exist or you don't have the permision to view it.")
		    end
		end

		context "when document is found" do
			before do
				Document.stub!(:find_by_id_and_document_fingerprint).with("#{document.id}", "#{document.document_fingerprint}").and_return(document)
				document.stub(:is_private?).and_return(false)
			end

			context "when the user is logged in" do
				login_user

				context "when the user created the document" do
					let(:referral) { mock_model(Referral, :referrer => subject.current_user) }

					before do
						referral.stub(:documents).and_return([document])
						document.stub(:is_follower?).and_return(false)
					end

					it "verifies that the user created the document" do
						document.should_receive(:is_creator?).with(subject.current_user.id)
	        			get :download, :id => document.id, :fingerprint => document.document_fingerprint
					end

					it "is able to view the document" do
						document.should_receive(:is_creator?).with(subject.current_user.id).and_return(true)
						controller.should_receive(:send_file).with(document.document.path, :type => document.document_content_type).and_return{controller.render :nothing => true}
						get :download, :id => document.id, :fingerprint => document.document_fingerprint
					end
				end

				context "when the user is a follower of the referral to which the document is assigned" do
					let(:referral) { mock_model(Referral) }

					before do
						referral.stub(:documents).and_return([document])
						referral.stub(:followers).and_return([subject.current_user])
						document.stub(:is_creator?).and_return(false)
					end

					it "verifies that the user is a follower" do
						document.should_receive(:is_follower?).with(subject.current_user.id)
	        			get :download, :id => document.id, :fingerprint => document.document_fingerprint
					end

					it "is able to view the document" do
						document.should_receive(:is_follower?).with(subject.current_user.id).and_return(true)
						controller.should_receive(:send_file).with(document.document.path, :type => document.document_content_type).and_return{controller.render :nothing => true}
						get :download, :id => document.id, :fingerprint => document.document_fingerprint
					end
				end

				context "when the user has 'all' referral tracking rights" do
					before do
						subject.current_user.track_referrals = 'all'
						document.stub(:is_creator?).and_return(false)
						document.stub(:is_follower?).and_return(false)
					end

					it "verifies that the user has 'all' referral tracking rights" do
						subject.current_user.should_receive(:track_referrals)
						get :download, :id => document.id, :fingerprint => document.document_fingerprint
					end

					it "when the document is not private is able to view the document" do
						controller.should_receive(:send_file).with(document.document.path, :type => document.document_content_type).and_return{controller.render :nothing => true}
						get :download, :id => document.id, :fingerprint => document.document_fingerprint
					end

					it "verifies that the document is not attached to a private referral" do
						document.should_receive(:is_private?)
						get :download, :id => document.id, :fingerprint => document.document_fingerprint
					end

					context "when the document is private" do
						before do
							document.stub(:is_private?).and_return(true)
						end

						it "redirects to referrals index page" do
							get :download, :id => document.id, :fingerprint => document.document_fingerprint
		        			response.should redirect_to(:controller => 'referrals', :action => 'index')
						end

						it "sets a flash[:error] message" do
					    	get :download, :id => document.id, :fingerprint => document.document_fingerprint
							flash[:error].should eq("You are not allowed to view the file you requested")
					    end
					end
				end

				context "when the user did not create the document, is not a follower of the referral and does not have 'all' tracking rights" do
					before do
						subject.current_user.track_referrals = 'initiated_and_assigned'
						document.stub(:is_creator?).and_return(false)
						document.stub(:is_follower?).and_return(false)
					end

					it "redirects to referrals index page" do
						get :download, :id => document.id, :fingerprint => document.document_fingerprint
	        			response.should redirect_to(:controller => 'referrals', :action => 'index')
					end

					it "sets a flash[:error] message" do
				    	get :download, :id => document.id, :fingerprint => document.document_fingerprint
						flash[:error].should eq("You are not allowed to view the file you requested")
				    end
				end
			end

			context "when the user is not logged in" do
				context "when staff memeber" do
					it "verifies that the user is a staff memeber" do
						StaffMember.should_receive(:is_staff_member?).with("123")
	        			get :download, :id => document.id, :fingerprint => document.document_fingerprint, :staff_member => "123"
					end

					it "is able to view download" do
						StaffMember.stub!(:is_staff_member?).and_return(true)
						controller.should_receive(:send_file).with(document.document.path, :type => document.document_content_type).and_return{controller.render :nothing => true}
						get :download, :id => document.id, :fingerprint => document.document_fingerprint
					end
				end

				context "when not staff member" do
					it "redirects to login page" do
						get :download, :id => document.id, :fingerprint => document.document_fingerprint
	        			response.should redirect_to(:controller => 'devise/sessions', :action => 'new')
					end

					it "sets a flash[:error] message" do
				    	get :download, :id => document.id, :fingerprint => document.document_fingerprint
						flash[:error].should eq("Login to view the file you requested")
				    end
				end
			end

		end
	end
end
