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
    constructor: function(contanier) {
       var html = [	
		'<div class="course  fill-container">',
			'<div class="left">',
			'<div class="img">',
            	'<img src="'+Cursame.Path+'/assets/course_small.png" />',
			'</div>',
			'</div>',
            '<div class="properties">',
				'<p>{title}</p>',
                /*'<div class="text">',
                 	'{description}',
                '</div>',*/
            '</div>',
        '</div>'];
		if(contanier){//si el template  debe de mostrar con minibar
			html.splice(0,1,'<div class="course">');			
		}
        this.callParent(html);
    }
});