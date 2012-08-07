/**
 * @class Cursame.view.notifications.CourseNavigationView
 * @extends Ext.navigation.View
 * The navigation view of the courses, this is to navigate between the courses
 */
Ext.define('Cursame.view.courses.CourseNavigationView', {
    extend: 'Ext.navigation.View',
	xtype:'coursenavigationview',
    
	requires:[
			'Cursame.view.courses.CourseList',
			'Cursame.view.courses.CourseMenu',
			'Cursame.view.users.UserList',
			'Cursame.view.assignments.AssignmentList',
			'Cursame.view.assignments.AssignmentWall',
			'Cursame.view.surveys.SurveyList',
			'Cursame.view.surveys.SurveyWall',
			'Cursame.view.discussions.DiscussionList',
			'Cursame.view.discussions.DiscussionWall'
		],
    config: {
        items:{
			xtype:'courselist',
			title:lang.courses
		},
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