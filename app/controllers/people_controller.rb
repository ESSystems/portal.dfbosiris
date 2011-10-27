class PeopleController < ApplicationController

  before_filter :init_options, :only => [:new, :edit, :update, :create]
  
  load_and_authorize_resource
  
  def init_options
    @genders = %w( M F )
  end
  
  def index
    if !current_user.nil?
      @people = Person.people_in_organisation(current_user.client_id)
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
    @person.added_by_referrer = true
    if @person.save
      @person.add_outside_person(current_user)
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