/**
 * @class Cursame.view.notifications.CourseNavigationView
 * @extends Ext.navigation.View
 * The navigation view of the courses, this is to navigate between the courses
 */
Ext.define('Cursame.view.users.UserNavigationView', {
    extend: 'Ext.navigation.View',
	xtype:'usernavigationview',
    
	requires:[
			'Cursame.view.users.UserWall'
	],
    config: {
        navigationBar: {
		            items: [
		                {
		                    iconCls: 'movistar',
		                    iconMask: true,
		                    ui: 'plain',
		                    align: 'right'
		                }
		            ],
		        }
    },
 	applyLayout: function(config) {
        config = config || {};
        if (Ext.os.is.Android) {
            config.animation = false;
        }
        return config;
    }
});