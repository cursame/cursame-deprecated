/**
 * @class Cursame.view.users.CommunityNavigationView.js
 * @extends Ext.navigation.View
 * The navigation view of the cursame community, this is to navigate between the communitty users
 * @author @manduks
 */
Ext.define('Cursame.view.users.CommunityNavigationView', {
	extend: 'Ext.navigation.View',
	xtype: 'communitynavigationview',

	requires: ['Cursame.view.users.UserList'],
	config: {
		items: {
			xtype: 'userslist',
			title: lang.members
		},
		navigationBar: {
			items: [{
				align: 'left',
				ui: 'back',
				itemId:'backBtn',
				text:'Back'
			}, {
				iconCls: 'movistar',
				iconMask: true,
				ui: 'plain',
				align: 'right'
			}],
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
