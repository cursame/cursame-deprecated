/**
 * @class Cursame.view.users.TopUserList
 * @extends Object
 * This component lists the tops users
 * @manduks
 */
Ext.define('Cursame.view.users.topusers.TopUserList', {
	extend: 'Ext.List',
	xtype: 'topuserslist',

	requires: ['Ext.plugin.PullRefresh', 'Ext.plugin.ListPaging'],

	config: {
		store: 'TopUsers',
		masked: {
			xtype: 'loadmask',
			message: lang.loading
		},
		scrollable: {
			direction: 'vertical',
			directionLock: true
		},
		disclosure: true,
		emptyText: lang.emptyText,
		itemTpl: Ext.create('Ext.XTemplate', '<div class="comment ">', '<div class="img">', '<img src="{avatar_file}" />', '</div>', '<div class="contenido">', '<div class="title">{first_name} {last_name}</div>', '<div class="text">', '{role}', '</div>', '</div>', '</div>')
	}
});