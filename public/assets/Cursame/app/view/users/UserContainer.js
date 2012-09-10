/**
 * @class Cursame.view.surveys.SurveyList
 * @extends Ext.List
 * This component lists the Surveys
 */
Ext.define('Cursame.view.users.UserContainer', {
    extend: 'Ext.Container',
	xtype:'usercontainer',
    
	requires:['Cursame.view.users.UserTpl'],
	
    config: {
		tpl: Ext.create('Cursame.view.users.UserTpl',false)
    }
});