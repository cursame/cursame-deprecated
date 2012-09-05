/*!
 * Back Button Detection Object V 1.0.1
 * http://www.brookebryan.com/
 *
 * Copyright 2010, Brooke Bryan
 *
 * Date: Thu 27 Jan 2011 13:37 GMT
 */

Ext.Loader.setPath({
    'Ext': '../assets/Cursame/sdk/src',
	'Core': '../assets/Cursame/core',
	'Cursame':'../assets/Cursame/app'
});	

Ext.application({
	
    name: 'Experto',
	viewport: {
     autoMaximize: true
    },	
	profiles:['Cursame.profile.Phone'],
	stores:['Notifications','Comments','CommentsComments','Courses','Users','Assignments','Surveys','Discussions'],

    views: ['Main'],

    icon: {
        57: 'resources/icons/Icon.png',
        72: 'resources/icons/Icon~ipad.png',
        114: 'resources/icons/Icon@2x.png',
        144: 'resources/icons/Icon~ipad@2x.png'
    },
    
    phoneStartupScreen: './resources/loading/Homescreen.jpg',
    tabletStartupScreen: './resources/loading/Homescreen~ipad.jpg',

    launch: function() {
        // Destroy the #appLoadingIndicator element
        Ext.fly('appLoadingIndicator').destroy();

        // Initialize the main view
        Ext.Viewport.add(Ext.create('Cursame.view.Main'));		
    },

    onUpdated: function() {
        Ext.Msg.confirm(
            "Application Update",
            "This application has just successfully been updated to the latest version. Reload now?",
            function() {
                window.location.reload();
            }
        );
    }
});


