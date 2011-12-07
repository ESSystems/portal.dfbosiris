class PeopleController < ApplicationController

  before_filter :init_options, :only => [:new, :edit, :update, :create]
  
  load_and_authorize_resource
  
  def init_options
    @genders = %w( M F )
    @organisations = Organisation.all
  end
  
  def index
    if !current_user.nil?
      #@people = Person.people_in_organisation(current_user.client_id).page(params[:page])
      @type = params[:type] == nil ? "" : params[:type]

      case @type
      when "employees"
        @employees = Person.employees_in_organisation(current_user.client_id).page(params[:page]).per(15)
        @outside_people = nil
      when "outside_people"
        @employees = nil
        @outside_people = Person.outside_people_in_organisation(current_user.client_id).page(params[:page]).per(15)
      else
        @employees = Person.employees_in_organisation(current_user.client_id).page(1).per(15)
        @outside_people = Person.outside_people_in_organisation(current_user.client_id).page(1).per(15)
      end
    end
  end
  
  def show
    @person = Person.find(params[:id])
  end
  
  def edit
    @person = Person.find(params[:id])
  end
  
  def new
    @person = Person.new
    @person.build_outside_person(:organisation_id => current_user.client_id)
  end
  
  def destroy
    @person = Person.find(params[:id])
    if @person.added_by_referrer
      if !current_user.nil? and @person.referrer.id == current_user.id
        @person.destroy
      end
    end
    redirect_to :action => "index"
  end
  
  def create
    @person = Person.new(params[:person])
    @person.add_outside_person(current_user)
    if @person.save
      flash[:success] = "New person created."
      redirect_to :action => "index"
    else
      flash.now[:error] = "Could not create new person."
      render :action => "new"
    end
  end
  
  def update
    @person = Person.find(params[:id])
    if @person.update_attributes(params[:person])
      flash[:success] = "Person was successfully updated."
      redirect_to :action => "show"
    else
      flash.now[:error] = "Could not update the person."
      render :action => "edit"
    end
  end
end