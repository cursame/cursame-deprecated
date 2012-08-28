/**
 * @class Cursame.view.users.UserWall
 * @extends Container
 * Description
 */
Ext.define('Cursame.view.users.UserWall', {
    extend: 'Ext.List',
	xtype:'userwall',
    
	requires:['Cursame.view.users.UserContainer'],
	
    config: {
		store:'Users',
		masked:{
		   // xtype: 'loadmask',
		    //message: lang.loading
		},
		scrollable: {
		    direction: 'vertical',
		    directionLock: true
		},
		items:[{
				xtype:'usercontainer'
		}],
		itemTpl: Ext.create('Cursame.view.users.UserTpl',true)
    }
});