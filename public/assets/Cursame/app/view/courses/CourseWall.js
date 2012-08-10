/**
 * @class Cursame.view.courses.CourseWall
 * @extends Container
 * Description
 */
Ext.define('Cursame.view.courses.CourseWall', {
    extend: 'Ext.List',
	xtype:'coursewall',
    
	requires:['Cursame.view.courses.CourseContainer','Cursame.view.comments.CommentTpl','Cursame.view.comments.CommentToolbar'],
	
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
		        xtype: 'commentbar'
		    }],
		itemTpl: Ext.create('Cursame.view.comments.CommentTpl',true)
    }
});