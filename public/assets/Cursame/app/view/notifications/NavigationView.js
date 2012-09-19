/**
 * @class Cursame.view.notifications.NavigationView
 * @extends Ext.navigation.View
 * The navigation view of the notifications, this is to navigate between the courses, assets,
 *  and all the entities that produce a notification on cursame
 */
Ext.define('Cursame.view.notifications.NavigationView', {
	extend: 'Ext.navigation.View',
	xtype: 'notificationnavigationview',

	requires: ['Cursame.view.notifications.NotificationsList', 'Cursame.view.courses.CourseWall', 'Cursame.view.comments.CommentWall'],
	config: {
		items: {
			xtype: 'notificationslist',
			title: lang.notifications
		},
		navigationBar: {
			items: [{
				align: 'right',
				text:lang.sign_out,
				itemId:'signOut',
				handler:function(){
					localStorage.removeItem('User');				
				}
			}/*, {
				iconCls: 'cursame',
				iconMask: true,
				ui: 'plain',
				align: 'right'
			}*/],
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
