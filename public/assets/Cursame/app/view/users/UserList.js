/**
 * @class Cursame.view.users.UserList
 * @extends Object
 * This component lists the users
 */
Ext.define('Cursame.view.users.UserList', {
	extend: 'Ext.List',
	xtype: 'userslist',

	requires: ['Ext.plugin.PullRefresh', 'Ext.plugin.ListPaging'],

	config: {
		store: 'Users',
		masked: {
			xtype: 'loadmask',
			message: lang.loading
		},
		scrollable: {
			direction: 'vertical',
			directionLock: true
		},
		disclosure: true,
		grouped: true,
		emptyText: lang.emptyText,
		indexBar: true,
		pluginsss: ['pullrefresh',
		{
			type: 'listpaging',
			autoPaging: true,
			loadMoreText: lang.loadMoreText
		}],
		items: [{
			xtype: 'toolbar',
			docked: 'top',
			layout: 'hbox',
			ui: 'accept',
			items: [{
				xtype: 'textfield',
				placeHolder: lang.searchUsers,
				flex: 5
			}, {
				xtype: 'button',
				text: lang.search,
				ui: 'accept',
				margin: 5,
				flex: 1
			}]
		}],
		itemTpl: Ext.create('Ext.XTemplate', '<div class="comment ">', '<div class="img">', '<img src="{avatar_file}" />', '</div>', '<div class="contenido">', '<div class="title">{first_name} {last_name}</div>', '<div class="text">', '{role}', '</div>', '</div>', '</div>')
	}
});