/**
 * @class Cursame.view.users.TopUsersNavigationView.js
 * @extends Ext.navigation.View
 * The navigation view of the top users module
 * @author @manduks
 */
Ext.define('Cursame.view.users.topusers.TopUsersNavigationView', {
	extend: 'Ext.navigation.View',
	xtype: 'topusersnavigationview',

	requires: ['Cursame.view.users.topusers.TopUserList'],
	config: {
		items: {
			xtype: 'topuserslist',
			title: lang.top
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
			}]
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
