/**
 * @class Cursame.view.surveys.Questions
 * @extends Ext.Carousel
 * The carousel for the sueyveys questions
 */
Ext.define('Cursame.view.surveys.Questions', {
	extend: 'Ext.Carousel',
	xtype: 'questionscarousel',
	beforeInitialize: function() {
		var me = this;
		this.mask( {
			xtype: 'loadmask',
			message: lang.loading
		});
		Ext.getStore('Questions').load({
			params: {
				id: me.initialConfig.surveyId
			},
			callback: me.loadQuestions,
			scope: this
		});
		this.callParent(arguments);
	},
	loadQuestions: function(argument) {
		var me = this,
			items = [];
		Ext.getStore('Questions').each(function(item, index, length) {
			var question = {
				xtype: 'container',
				defaults: {
					cls: 'question'
				},
				scrollable: {
					direction: 'vertical',
					directionLock: true
				},
				items: [{
					xtype: 'container',
					tpl: Ext.create('Ext.XTemplate', '<div class="course  fill-container ">', '<div class="properties" style = "padding:20px">', '<p font-size = "18px">{text}</p>', '</div>', '</div>'),
					data: item.data
				}]
			};

			Ext.each(item.data.answers, function(obj) {
				question.items.push({
					xtype: 'container',
					layout: 'hbox',
					items: [{
						name: 'question_id_' + obj.question_id,
						xtype: 'radiofield',
						width: 60
					}, {
						xtype: 'label',
						itemId: 'myLabel',
						data: obj,
						flex: 1,
						tpl: ['<div class="answer">{text}</div>']
					}]
				});
			}, this);
			items.push(question);
		});
		items.push({
			xtype:'container',
			items:[{
				xtype:'button',
				align:'center',
				text:'Finalizar Cuestionario'
			}]
		});
		me.setItems(items);
		me.setActiveItem(0);
		this.unmask();
	}
});