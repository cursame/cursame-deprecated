/**
 * @class Cursame.view.phone.Main
 * @extends Cursame.view.Main
 * This is the main class for our iphone application
 */
Ext.define('Cursame.view.phone.Main', {
	extend: 'Cursame.view.Main',
	requires: ['Ext.tab.Panel', 'Cursame.view.users.UserNavigationView'],

	config: {
		layout: 'card',
		items: [{
			xtype: 'loginform',
			scrollable: false
		}, {
			xtype: 'tabpanel',
			fullscreen: true,
			activeItem: 0,
			tabBarPosition: 'bottom',
			items: [/*{
				xtype: 'networknavigationview',
				iconCls: 'chat',
				type :'wall',
				title: lang.wall
			},*/{
				xtype: 'notificationnavigationview',
				iconCls: 'rss_black2',
				type:'notifications',
				title: lang.notifications
			}, {
				xtype: 'coursenavigationview',
				iconCls: 'tags',
				type:'courses',
				title: lang.courses
			}, {
				xtype: 'usernavigationview',
				type: 'user',
				title: lang.profilee,
				iconCls: 'user_list'
			}, {
				xtype: 'communitynavigationview',
				type: 'userlist',				
				title: lang.community,
				iconCls: 'team1'
			}]
		}]
	}
});
