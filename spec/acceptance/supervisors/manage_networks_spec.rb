require 'spec_helper'

feature 'Supervisor', %q{
  In order to manage my network
  As a supervisor
  I want to switch networks and edit settings for them
} do

  background do
    @network    = Factory(:network)
    @supervisor = Factory(:supervisor, :networks => [@network])
    sign_in_with @supervisor, :subdomain => @network.subdomain
  end

  scenario 'editing network attributes' do
    visit edit_supervisor_network_url :subdomain => @network.subdomain
    fill_in 'network[slogan]',          :with => 'Errare human est'
    fill_in 'network[welcome_message]', :with => 'Bienvenida!!'
    select '(GMT-06:00) Guadalajara',   :from => 'network[time_zone]'
    click_button 'submit'

    Network.should exist_with :slogan => 'Errare human est', :welcome_message => 'Bienvenida!!', :time_zone => 'Guadalajara'
    page.should have_notice I18n.t('flash.network_updated')
  end
end
