/**
 * @class Cursame.view.network.NetworkWall
 * @extends Ext.List
 * This the network wall component
 */
Ext.define('Cursame.view.network.NetworkWall', {
    extend: 'Ext.List',
	xtype:'networkwall',
    
	requires:['Cursame.view.comments.CommentTpl',
			'Cursame.view.comments.CommentToolbar',
			'Ext.plugin.PullRefresh',
			'Ext.plugin.ListPaging'],
	
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
		plugins: [
            'pullrefresh',
            {
                type: 'listpaging',
                autoPaging: true,
				loadMoreText:lang.loadMoreText
            }
        ],
		items:[{		      
		        xtype: 'commentbar'
		    }],
		itemTpl: Ext.create('Cursame.view.comments.CommentTpl',true)
    }
});