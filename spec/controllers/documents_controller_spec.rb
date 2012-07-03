require 'spec_helper'

describe DocumentsController do
	let(:document) { mock_model(Document, :document => fixture_file_upload(Rails.root.join("spec/support/files/beans.jpg"), 'image/jpeg'), :document_content_type => "image/jpeg", :document_fingerprint => "387efeb850df115915c74452c4c74rey", :document_file_name => "Beans") }

	before do
		document.stub(:path).and_return(document.document.path)
		document.stub(:osiris_url).and_return(document.document.path) # we don't test the actual origin of the file
	end

	def run_action
		get :download, :id => document.id, :fingerprint => document.document_fingerprint
	end

	describe "download" do
		it "calls find_by_document_fingerprint on Document" do
			Document.should_receive(:find_by_id_and_document_fingerprint)
        	run_action
		end

		context "when document is not found" do
			before do
				Document.stub!(:find_by_id_and_document_fingerprint).with("#{document.id}", "#{document.document_fingerprint}").and_return(nil)
			end

			it "redirects to referrals index page" do
				run_action
    			response.should redirect_to(:controller => 'referrals', :action => 'index')
			end

			it "sets a flash[:error] message" do
		    	run_action
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


				shared_examples "able to view document" do
					it "verifies if the document has osiris origin" do
						document.should_receive(:from_osiris?)
						run_action
					end

					it "uses osiris url if the document is from osiris" do
						document.stub(:from_osiris?).and_return(true)
						document.should_receive(:osiris_url)
						run_action
					end

					it "uses document path if the document is not from osiris" do
						document.stub(:from_osiris?).and_return(false)
						document.should_receive(:path)
						run_action
					end

					context "shows data" do
						before do
							document.stub(:from_osiris?).and_return(false)
						end

						it "uses open-uri to open source" do
							controller.stub(:open).and_return(open(document.path))
							controller.should_receive(:open).with(document.path)
							run_action
						end

						it "uses send_data" do
							data = open(document.path)
							controller.should_receive(:send_data).with(data.read, :type => document.document_content_type, :filename => document.document_file_name).and_return{controller.render :nothing => true}
							run_action
						end
					end
				end

				context "when the user created the document" do
					let(:referral) { mock_model(Referral, :referrer => subject.current_user) }

					before do
						referral.stub(:documents).and_return([document])
						document.stub(:is_follower?).and_return(false)
					end

					it "verifies that the user created the document" do
						document.stub(:from_osiris?).and_return(false)
						document.should_receive(:is_creator?).with(subject.current_user.id)
						run_action
					end

					context "is able to view the document" do
						before do
							document.stub(:is_creator?).with(subject.current_user.id).and_return(true)
						end

						include_examples "able to view document"
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
						document.stub(:from_osiris?).and_return(false)
						document.should_receive(:is_follower?).with(subject.current_user.id)
						run_action
					end

					context "is able to view the document" do
						before do
							document.stub(:is_follower?).with(subject.current_user.id).and_return(true)
						end

						include_examples "able to view document"
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
						run_action
					end

					include_examples "able to view document"

					it "verifies that the document is not attached to a private referral" do
						document.stub(:from_osiris?).and_return(false)
						document.should_receive(:is_private?)
						run_action
					end

					context "when the document is private" do
						before do
							document.stub(:is_private?).and_return(true)
						end

						it "redirects to referrals index page" do
							run_action
		        			response.should redirect_to(:controller => 'referrals', :action => 'index')
						end

						it "sets a flash[:error] message" do
					    	run_action
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
						run_action
	        			response.should redirect_to(:controller => 'referrals', :action => 'index')
					end

					it "sets a flash[:error] message" do
						run_action
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
						run_action
					end
				end

				context "when not staff member" do
					it "redirects to login page" do
						run_action
	        			response.should redirect_to(:controller => 'devise/sessions', :action => 'new')
					end

					it "sets a flash[:error] message" do
				    	run_action
						flash[:error].should eq("Login to view the file you requested")
				    end
				end
			end

		end
	end
end
