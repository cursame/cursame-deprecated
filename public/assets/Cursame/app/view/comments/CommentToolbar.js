/**
 * @class Cursame.view.comments.CommentToolbar
 * @extends Ext.Toolbar
 * Description
 */
Ext.define('Cursame.view.comments.CommentToolbar', {
    extend: 'Ext.Toolbar',
    xtype:'commentbar',

    config: {
        docked: 'bottom',
		ui:'accept',
		layout:'hbox',				
		items:[{
	    	xtype: 'textfield',
			placeHolder: lang.sendComment,
			flex: 5
	       },{
	       	xtype: 'button',
			text: lang.send,
			disabled:true,
			ui: 'accept',
			margin: 5,
			flex: 1
	    }]			
	}
});