/** * 
* @class Cursame.view.discussions.DiscussionList * 
* @extends Ext.List  
* This component lists the Surveys */
Ext.define('Cursame.view.discussions.DiscussionList', { 
	extend: 'Ext.List',
	xtype:'discussionslist',

 	requires:['Cursame.view.discussions.DiscussionTpl'],

    config: {
        store:'Discussions',
		masked:{
		    xtype: 'loadmask',
		    message: lang.loading
		},
		scrollable: {
		    direction: 'vertical',
		    directionLock: true
		},
		itemTpl: Ext.create('Cursame.view.discussions.DiscussionTpl',false)
    }
});