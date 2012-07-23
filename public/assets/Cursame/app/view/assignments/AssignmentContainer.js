/**
 * @class Cursame.view.courses.AssignmentContainer
 * @extends Ext.Container
 * Este es el contenedor que muestran 
 */
Ext.define('Cursame.view.assignments.AssignmentContainer', {
    extend: 'Ext.Container',
	xtype:'assignmentcontainer',
    
	requires:['Cursame.view.assignments.AssignmentTpl'],

    config: {
        tpl : Ext.create('Cursame.view.assignments.AssignmentTpl',true)
    }
});