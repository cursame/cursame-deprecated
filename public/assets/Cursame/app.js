Ext.Loader.setPath({
    'Ext': '../assets/Cursame/sdk/src',
	'Core': '../assets/Cursame/core',
	'Cursame':'../assets/Cursame/app'
});	
console.log(Ext.browser);
Ext.application({
	
    name: 'Cursame',
	viewport: {
     autoMaximize: !Ext.browser.is.Standalone && !Ext.browser.is.chromemobile && Ext.os.is.iOS && Ext.browser.version.isGreaterThan(3)
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
    
    phoneStartupScreen: 'resources/loading/Homescreen.jpg',
    tabletStartupScreen: 'resources/loading/Homescreen~ipad.jpg',

    launch: function() {
        // Destroy the #appLoadingIndicator element
        Ext.fly('appLoadingIndicator').destroy();

        // Initialize the main view
        Ext.Viewport.add(Ext.create('Cursame.view.Main'));
		console.log(Ext.browser);
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
