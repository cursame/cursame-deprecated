/**
 * @class Cursame.view.assignments.AssignmentList
 * @extends Ext.List
 * This component lists the Assignments
 */
Ext.define('Cursame.view.assignments.AssignmentList', {
    extend: 'Ext.List',
	xtype:'assignmentslist',
	
    requires:['Cursame.view.assignments.AssignmentTpl'],

    config: {
        store:'Assignments',
		masked:{
		    xtype: 'loadmask',
		    message: lang.loading
		},
		scrollable: {
		    direction: 'vertical',
		    directionLock: true
		},
		itemTpl: Ext.create('Cursame.view.assignments.AssignmentTpl',false)
    }
});