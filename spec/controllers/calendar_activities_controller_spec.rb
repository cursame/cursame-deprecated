require 'spec_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to specify the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator.  If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails.  There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.
#
# Compared to earlier versions of this generator, there is very limited use of
# stubs and message expectations in this spec.  Stubs are only used when there
# is no simpler way to get a handle on the object needed for the example.
# Message expectations are only used when there is no simpler way to specify
# that an instance is receiving a specific message.

describe CalendarActivitiesController do

  # This should return the minimal set of attributes required to create a valid
  # CalendarActivity. As you add validations to CalendarActivity, be sure to
  # update the return value of this method accordingly.
  def valid_attributes
    {}
  end
  
  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # CalendarActivitiesController. Be sure to keep this updated too.
  def valid_session
    {}
  end

  describe "GET index" do
    it "assigns all calendar_activities as @calendar_activities" do
      calendar_activity = CalendarActivity.create! valid_attributes
      get :index, {}, valid_session
      assigns(:calendar_activities).should eq([calendar_activity])
    end
  end

  describe "GET show" do
    it "assigns the requested calendar_activity as @calendar_activity" do
      calendar_activity = CalendarActivity.create! valid_attributes
      get :show, {:id => calendar_activity.to_param}, valid_session
      assigns(:calendar_activity).should eq(calendar_activity)
    end
  end

  describe "GET new" do
    it "assigns a new calendar_activity as @calendar_activity" do
      get :new, {}, valid_session
      assigns(:calendar_activity).should be_a_new(CalendarActivity)
    end
  end

  describe "GET edit" do
    it "assigns the requested calendar_activity as @calendar_activity" do
      calendar_activity = CalendarActivity.create! valid_attributes
      get :edit, {:id => calendar_activity.to_param}, valid_session
      assigns(:calendar_activity).should eq(calendar_activity)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new CalendarActivity" do
        expect {
          post :create, {:calendar_activity => valid_attributes}, valid_session
        }.to change(CalendarActivity, :count).by(1)
      end

      it "assigns a newly created calendar_activity as @calendar_activity" do
        post :create, {:calendar_activity => valid_attributes}, valid_session
        assigns(:calendar_activity).should be_a(CalendarActivity)
        assigns(:calendar_activity).should be_persisted
      end

      it "redirects to the created calendar_activity" do
        post :create, {:calendar_activity => valid_attributes}, valid_session
        response.should redirect_to(CalendarActivity.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved calendar_activity as @calendar_activity" do
        # Trigger the behavior that occurs when invalid params are submitted
        CalendarActivity.any_instance.stub(:save).and_return(false)
        post :create, {:calendar_activity => {}}, valid_session
        assigns(:calendar_activity).should be_a_new(CalendarActivity)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        CalendarActivity.any_instance.stub(:save).and_return(false)
        post :create, {:calendar_activity => {}}, valid_session
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested calendar_activity" do
        calendar_activity = CalendarActivity.create! valid_attributes
        # Assuming there are no other calendar_activities in the database, this
        # specifies that the CalendarActivity created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        CalendarActivity.any_instance.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, {:id => calendar_activity.to_param, :calendar_activity => {'these' => 'params'}}, valid_session
      end

      it "assigns the requested calendar_activity as @calendar_activity" do
        calendar_activity = CalendarActivity.create! valid_attributes
        put :update, {:id => calendar_activity.to_param, :calendar_activity => valid_attributes}, valid_session
        assigns(:calendar_activity).should eq(calendar_activity)
      end

      it "redirects to the calendar_activity" do
        calendar_activity = CalendarActivity.create! valid_attributes
        put :update, {:id => calendar_activity.to_param, :calendar_activity => valid_attributes}, valid_session
        response.should redirect_to(calendar_activity)
      end
    end

    describe "with invalid params" do
      it "assigns the calendar_activity as @calendar_activity" do
        calendar_activity = CalendarActivity.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        CalendarActivity.any_instance.stub(:save).and_return(false)
        put :update, {:id => calendar_activity.to_param, :calendar_activity => {}}, valid_session
        assigns(:calendar_activity).should eq(calendar_activity)
      end

      it "re-renders the 'edit' template" do
        calendar_activity = CalendarActivity.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        CalendarActivity.any_instance.stub(:save).and_return(false)
        put :update, {:id => calendar_activity.to_param, :calendar_activity => {}}, valid_session
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested calendar_activity" do
      calendar_activity = CalendarActivity.create! valid_attributes
      expect {
        delete :destroy, {:id => calendar_activity.to_param}, valid_session
      }.to change(CalendarActivity, :count).by(-1)
    end

    it "redirects to the calendar_activities list" do
      calendar_activity = CalendarActivity.create! valid_attributes
      delete :destroy, {:id => calendar_activity.to_param}, valid_session
      response.should redirect_to(calendar_activities_url)
    end
  end

end