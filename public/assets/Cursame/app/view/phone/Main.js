/**
 * @class Cursame.view.phone.Main
 * @extends Cursame.view.Main
 * This is the main class for our iphone application
 */
Ext.define('Cursame.view.phone.Main', {
    extend: 'Cursame.view.Main',
	requires:['Ext.tab.Panel','Cursame.view.users.UserNavigationView'],
	
	config: {
        layout: 'card',
        items: [{
			xtype:'loginform',		
			scrollable:false
		},{
			xtype:'tabpanel',
			fullscreen:true,
	        activeItem:0,
	        tabBarPosition:'bottom',
			items:[{
				xtype:'notificationnavigationview',
				iconCls:'help_black'
			},{
				xtype:'coursenavigationview',
				iconCls:'docs_black1'
			},{
				xtype:'usernavigationview',
				type:'user',
				iconCls:'user_list'
			}]
		}]
    }
});