/**
 * @class Cursame.view.discussions.DiscussionTpl
 * @extends Ext.XTemplate
 *
 * This is the xtemplate for the Discussions
 *
 * @manduks april 2012
 */
Ext.define('Cursame.view.discussions.DiscussionTpl', {
    extend: 'Ext.XTemplate',
    constructor: function (container) {
        var html;
        if (!container) {
            html = ['<div class="course  fill-container">', '<div class="left">', '<div class="img">', '<img src="' + Cursame.Path + '/assets/course_small.png" />', '</div>', '</div>', '<div class="properties">', '<p>{title}</p>', '</div>', '</div>'];
        } else {
            html = ['<div class="comment fill-container">', '<div class="img">', '<img src="' + Cursame.Path + '/assets/course_small.png" />', '</div>', '<div class="contenido">', '<div class="title">{title}</div>', '<div class="text">', '{description}', '</div>', '</div>', '</div>'];
        }

        if (container) { //si el template  debe de mostrar con minibar
            html.splice(0, 1, '<div class="comment">');
        }
        this.callParent(html);
    }
});