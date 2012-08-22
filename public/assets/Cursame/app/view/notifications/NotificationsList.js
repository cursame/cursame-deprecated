/**
 * @class MyNamespace.NotificationsList
 * @extends Object
 * Description
 */
Ext.define('Cursame.view.notifications.NotificationsList', {
    extend: 'Ext.dataview.DataView',
    xtype:'notificationslist',

	requires:[
		'Cursame.view.notifications.NotificationListItem',
		'Ext.plugin.PullRefresh',
		'Ext.plugin.ListPaging'
	],
    config: {
		ui:'notification',
		defaultType		: 'notificationlistitem',
		store			: 'Notifications',
        allowDeselect	: false,
        useComponents	: true,
        emptyText		: 'Nothing found.',
		plugins: [
            'pullrefresh',
            {
                type: 'listpaging',
                autoPaging: true
            }
        ]
    }
});