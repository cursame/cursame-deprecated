desc "Corrige las zonas y perfiles nulos de telefonica"
task :corrige_usuarios => :environment do

  csv_users = [
  	{ :first_name => 'felix agustin', :last_name => 'ortega garcia', :email => 'felixagustinortega@prodigy.net.mx' :telefonica_role => 'vendedor', :telefonica_zone => 'centro', :passwd => 'telefonica1' },
	{ :first_name => 'luz edith', :last_name => 'diaz cortes', :email => 'campanitaluz09@hotmail.com' :telefonica_role => 'vendedor', :telefonica_zone => 'centro', :passwd => 'telefonica2' },
	{ :first_name => 'viridiana guadalupe', :last_name => 'bautista villarreal', :email => 'vra_929612@hotmail.com' :telefonica_role => 'vendedor', :telefonica_zone => 'norte', :passwd => 'telefonica3' },
	{ :first_name => 'ronnie alejandro', :last_name => 'estrada alberto', :email => 'kurt_soulbreed@hotmail.com' :telefonica_role => 'vendedor', :telefonica_zone => 'norte', :passwd => 'telefonica4' },
	{ :first_name => 'yamily ', :last_name => 'campos alvarado', :email => 'yami-chivas@hotmail.com' :telefonica_role => 'vendedor', :telefonica_zone => 'norte', :passwd => 'telefonica5' },
	{ :first_name => 'ubaldo', :last_name => 'pantoja ramos', :email => 'baldo._10@hotmail.com' :telefonica_role => 'vendedor', :telefonica_zone => 'norte', :passwd => 'telefonica6' },
	{ :first_name => 'jose luis ', :last_name => 'ibarra rodriguez', :email => 'joseluis_ibarra@hotmail.com' :telefonica_role => 'vendedor', :telefonica_zone => 'norte', :passwd => 'telefonica7' },
	{ :first_name => 'job emmanuel', :last_name => 'rodriguez jara', :email => 'job77@live.com.mx' :telefonica_role => 'vendedor', :telefonica_zone => 'norte', :passwd => 'telefonica8' },
	{ :first_name => 'eduardo', :last_name => 'hernandez zayas ', :email => 'spider_z85@hotmail.com' :telefonica_role => 'vendedor', :telefonica_zone => 'norte', :passwd => 'telefonica9' },
	{ :first_name => 'elsie janaid', :last_name => 'santillan ortega', :email => 'subebe2@gmail.com' :telefonica_role => 'vendedor', :telefonica_zone => 'norte', :passwd => 'telefonica10' },
	{ :first_name => 'lidia gabriela', :last_name => 'leyva lopez', :email => 'minicac.guamuchil@gmail.com' :telefonica_role => 'vendedor', :telefonica_zone => 'norte', :passwd => 'telefonica11' },
	{ :first_name => 'juan manuel', :last_name => 'ferrel becerril', :email => 'jmferrelb@hotmail.com' :telefonica_role => 'vendedor', :telefonica_zone => 'centro', :passwd => 'telefonica12' },
	{ :first_name => 'juan francisco ', :last_name => 'garcia reyna', :email => 'lobogarey@gmail.com' :telefonica_role => 'vendedor', :telefonica_zone => 'occidente', :passwd => 'telefonica13' },
	{ :first_name => 'alejandra', :last_name => 'sanchez de los santos', :email => 'sanchez_ale22@hotmail.com' :telefonica_role => 'vendedor', :telefonica_zone => 'sur', :passwd => 'telefonica14' },
	{ :first_name => 'veronica alejandra', :last_name => 'sanchez de los santos', :email => 'sanchez_ale22@hotmail.com' :telefonica_role => 'vendedor', :telefonica_zone => 'sur', :passwd => 'telefonica15' },
	{ :first_name => 'jose vicente', :last_name => 'salazar dolores', :email => 'deko_1709@hotmail.com' :telefonica_role => 'vendedor', :telefonica_zone => 'sur', :passwd => 'telefonica16' },
	{ :first_name => 'norma yessica', :last_name => 'gonzalez herrera', :email => 'yessi.glz.capricornio@gmail.com' :telefonica_role => 'vendedor', :telefonica_zone => 'sur', :passwd => 'telefonica17' },
	{ :first_name => 'javier', :last_name => 'gomez perez', :email => 'gomez.1958@hotmail.com' :telefonica_role => 'vendedor', :telefonica_zone => 'sur', :passwd => 'telefonica18' },
	{ :first_name => 'juan', :last_name => 'velazquez lopez', :email => 'jvlrey@hotmail.com' :telefonica_role => 'vendedor', :telefonica_zone => 'sur', :passwd => 'telefonica19' },
	{ :first_name => 'david', :last_name => 'carro dominguez', :email => 'dcd37@hotmail.com' :telefonica_role => 'vendedor', :telefonica_zone => 'sur', :passwd => 'telefonica20' },
	{ :first_name => 'daniel', :last_name => 'nevarez', :email => 'daniel.nevarez@telefonica.com' :telefonica_role => 'vendedor', :telefonica_zone => 'norte', :passwd => 'telefonica21' },
	{ :first_name => 'felix agustin ', :last_name => 'ortega  garcia', :email => 'felixagustinortega@prodigy.net.mx' :telefonica_role => 'vendedor', :telefonica_zone => 'centro', :passwd => 'telefonica22' },
	{ :first_name => 'gabriela ', :last_name => 'ponce reyes', :email => 'samore0830@hotmail.com' :telefonica_role => 'vendedor', :telefonica_zone => 'centro', :passwd => 'telefonica23' },
	{ :first_name => 'nestor ivan', :last_name => 'osorio cortes', :email => 'mrkphone@hotmail.com' :telefonica_role => 'vendedor', :telefonica_zone => 'sur', :passwd => 'telefonica24' },
	{ :first_name => 'veronica', :last_name => 'cota', :email => 'verocota.celco@hotmail.com' :telefonica_role => 'vendedor', :telefonica_zone => 'norte', :passwd => 'telefonica25' },
	{ :first_name => 'norman ', :last_name => 'bobadilla', :email => 'normanbobadilla@hotmail.com' :telefonica_role => 'vendedor', :telefonica_zone => 'norte', :passwd => 'telefonica26' },
	{ :first_name => 'martina ', :last_name => 'sanchez monjardin', :email => 'martina.sanchezmonjardin@yahoo.com.mx' :telefonica_role => 'vendedor', :telefonica_zone => 'norte', :passwd => 'telefonica27' },
	{ :first_name => 'jose manuel', :last_name => 'rojo', :email => 'jomaro.movistar@gmail.com' :telefonica_role => 'vendedor', :telefonica_zone => 'norte', :passwd => 'telefonica28' },
	{ :first_name => 'dorhen', :last_name => 'robles', :email => 'dorhen.maxcell@gmail.com' :telefonica_role => 'vendedor', :telefonica_zone => 'norte', :passwd => 'telefonica29' },
	{ :first_name => 'isaura', :last_name => 'inzunza', :email => 'movistar.rosales@hotmail.com' :telefonica_role => 'vendedor', :telefonica_zone => 'norte', :passwd => 'telefonica30' },
	{ :first_name => 'rosario', :last_name => 'hernandez', :email => 'rosariotij@hotmail.com' :telefonica_role => 'vendedor', :telefonica_zone => 'norte', :passwd => 'telefonica31' },
	{ :first_name => 'viridiana', :last_name => 'reyes campas', :email => 'viridiana.reyes.ext@telefonica.com' :telefonica_role => 'vendedor', :telefonica_zone => 'norte', :passwd => 'telefonica32' },
	{ :first_name => 'mayra emmanuela', :last_name => 'cruz bejarano', :email => 'mayra.cruz.ext@telefonica.com' :telefonica_role => 'vendedor', :telefonica_zone => 'norte', :passwd => 'telefonica33' },
	{ :first_name => 'ducel miriam', :last_name => 'bool villavisencio', :email => 'dulcebool@hotmail.com' :telefonica_role => 'vendedor', :telefonica_zone => 'norte', :passwd => 'telefonica34' },
	{ :first_name => 'carlos', :last_name => 'carlon magana', :email => 'karlos_ens@hotmail.com' :telefonica_role => 'vendedor', :telefonica_zone => 'norte', :passwd => 'telefonica35' },
	{ :first_name => 'judith', :last_name => 'sanchez mejia', :email => 'judith.sanchez.ext@telefonica.com' :telefonica_role => 'vendedor', :telefonica_zone => 'norte', :passwd => 'telefonica36' },
	{ :first_name => 'cristian fernando', :last_name => 'velarde lizarraga', :email => 'cristian.velarde.ext@telefonica.com' :telefonica_role => 'vendedor', :telefonica_zone => 'norte', :passwd => 'telefonica37' },
	{ :first_name => 'veronica', :last_name => 'beristain bastida', :email => 'veronica.beristain.ext@telefonica.com' :telefonica_role => 'vendedor', :telefonica_zone => 'norte', :passwd => 'telefonica38' },
	{ :first_name => 'kalid giovanni', :last_name => 'farias barrios', :email => 'almacenensenadar1@gmail.com' :telefonica_role => 'vendedor', :telefonica_zone => 'norte', :passwd => 'telefonica39' }
  ]

  csv_users.each do |user|
    email = user[:email]
    tmp_user = User.find_by_email(email)
      if tmp_user.nil?
        puts "warning: usuario no encontrado => " + email
        new_user = User.new :first_name => user[:first_name], :last_name => user[:last_name], :email => user[:email], :telefonica_role => user[:telefonica_role], :telefonica_zone => user[:telefonica_zone]
      	new_user.password = user[:passwd]
      	new_user.save!
      else
      	puts "info: actualizando usuario " + email
        tmp_user.telefonica_role = user[:telefonica_role]
        tmp_user.telefonica_zone = user[:telefonica_zone]
        tmp_user.password = user[:passwd]
        tmp_user.save!
      end
  end
end
