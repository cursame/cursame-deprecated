/**
 * @class Cursame.view.assignments.AssignmentTpl
 * @extends Ext.XTemplate
 *
 * This is the xtemplate for the surveys
 *
 * @manduks april 2012
 */
Ext.define('Cursame.view.assignments.AssignmentTpl', {
    extend: 'Ext.XTemplate',
    constructor: function (container) {
		var html;
        if (!container) {
            html = ['<div class="course fill-container">', '<div class="left">', '<div class="img"><img src="' + Cursame.Path + '/assets/course_small.png" /></div>', '</div>', '<div class="properties">', '<p>{name}</p>','</div>', '</div>'];
        } else {
            html = ['<div class="course fill-container">', '<div class="left">', '<div class="img"><img src="' + Cursame.Path + '/assets/course_small.png" /></div>', '</div>', '<div class="properties">', '<p>{name}</p>', '<div>', '<em class="prop">' + lang.valuee + ': </em><em class="val">{value}</em></br>', '<em class="prop">' + lang.period + ': </em><em class="val">{period}</em>', '</div>', '<div><em class="prop">' + lang.limitDate + ': </em><em class="val">{due_to}</em></div>', '<div class="description">{description}</div>', '</div>', '</div>'];
        }

        if (container) { //si el template  debe de mostrar con minibar
            html.splice(0, 1, '<div class="course">');
        }
        this.callParent(html);
    }
});