/**
 * @class Cursame.view.surveys.SurveyList
 * @extends Ext.List
 * This component lists the Surveys
 */
Ext.define('Cursame.view.surveys.SurveyList', {
	extend: 'Ext.List',
	xtype: 'surveyslist',

	requires: ['Cursame.view.surveys.SurveyTpl', 'Cursame.view.surveys.Questions'],

	config: {
		store: 'Surveys',
		masked: {
			xtype: 'loadmask',
			message: lang.loading
		},
		emptyText: 'No tienes cuestionarios asignados :)',
		scrollable: {
			direction: 'vertical',
			directionLock: true
		},
		itemTpl: Ext.create('Cursame.view.surveys.SurveyTpl', false)
	}
});