/**
 * @class Cursame.view.discussions.DiscussionContainer
 * @extends Ext.Container
 * Este es el contenedor que muestran 
 */
Ext.define('Cursame.view.discussions.DiscussionContainer', {
    extend: 'Ext.Container',
	xtype:'discussioncontainer',
    
	requires:['Cursame.view.discussions.DiscussionTpl'],

    config: {
        tpl : Ext.create('Cursame.view.discussions.DiscussionTpl',true)
    }
});