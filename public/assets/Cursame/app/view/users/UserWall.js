/**
 * @class Cursame.view.users.UserWall
 * @extends Ext.List
 * @author Armando Gonzalez <iam@armando.mx>
 * the user wall container
 */
Ext.define('Cursame.view.users.UserWall', {
    extend: 'Ext.List',
	xtype:'userwall',
    
	requires:['Cursame.view.users.UserContainer','Cursame.view.comments.CommentTpl','Cursame.view.comments.CommentToolbar'],
	
    config: {
		store:'Comments',
		masked:{
		   	xtype: 'loadmask',
		    message: lang.loading
		},
		scrollable: {
		    direction: 'vertical',
		    directionLock: true
		},
		items:[{
				xtype:'usercontainer'
			},{		      
			    xtype: 'commentbar'
			}],
		itemTpl: Ext.create('Cursame.view.comments.CommentTpl',true)
    }
});