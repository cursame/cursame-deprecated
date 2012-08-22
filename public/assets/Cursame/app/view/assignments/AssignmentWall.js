/**
 * @class Cursame.view.assignments.AssignmentWall
 * @extends Container
 * Description
 */
Ext.define('Cursame.view.assignments.AssignmentWall', {
    extend: 'Ext.List',
	xtype:'assignmentwall',
    
	requires:['Cursame.view.assignments.AssignmentContainer','Cursame.view.comments.CommentTpl','Cursame.view.comments.CommentToolbar'],
	
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
				xtype:'assignmentcontainer'
			}/*,{		      
		        xtype: 'commentbar'
		    }*/],
		itemTpl: Ext.create('Cursame.view.comments.CommentTpl',true)
    }
});