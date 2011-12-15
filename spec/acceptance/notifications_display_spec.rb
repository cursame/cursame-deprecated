feature 'Notifications display', %q{
  In order to keep up to date
  As a user
  I want to see my notifications
} do

  background do
    @network = Factory(:network)
    @user    = Factory(:user, :networks => [@network])
    sign_in_with @user, :subdomain => @network.subdomain
  end



end
