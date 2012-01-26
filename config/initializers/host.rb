 if Rails.env.production?
  HOST = 'cursame.herokuapp.com'
 elsif Rails.env.staging?
   HOST = 'cursatest.com'
 else
   HOST = 'lvh.me'
  end
