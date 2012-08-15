Ext.define("Cursame.view.Main", {
    extend: 'Ext.Container',	
	xtype:'main',
	
	requires:[
		'Cursame.view.LoginForm',
		'Cursame.view.notifications.NotificationsList',
		'Cursame.view.notifications.NavigationView',
		'Cursame.view.courses.CourseNavigationView',
		'Cursame.view.users.UserNavigationView',
		'Cursame.view.users.CommunityNavigationView',
		'Cursame.view.comments.CommentTpl',
		'Cursame.view.users.UserTpl',
		'Cursame.view.assignments.AssignmentTpl',
		'Cursame.view.surveys.SurveyTpl',
		'Cursame.view.discussions.DiscussionTpl'
	],
	
	config: {
        layout: 'card',
        fullscreen: true,
		//autoMaximize : true
        autoDestroy: false
    }	
    
});