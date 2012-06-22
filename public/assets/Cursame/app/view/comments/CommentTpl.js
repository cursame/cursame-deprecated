/**
 * @class Cursame.view.comments.CommentTpl
 * @extends Ext.XTemplate
 *
 * This is the xtemplate for the comments
 *
 * @manduks april 2012
 */

Ext.define('Cursame.view.comments.CommentTpl', {
    extend: 'Ext.XTemplate',
    constructor: function(minibar) {	
		var html,minibar;		 
        html = ['<div class="comment ">',
						'<div class="img">',
                        	'<img src="'+Cursame.Path+'/assets/course_small.png" />',
						'</div>',
                        '<div class="contenido">',
                            '<div class="title">{userfirstname} {userlasttname}</div>',
                            '<div class="text">',
                                '{text}',
                            '</div>',
                             '<!-- minibar -->',//aqui va el minibar cuando se necesite y es la posicion nueve del arreglo
                        '</div>',
               '</div>'];
		minibarhtml = [		
					'<div class="minibar">',
						'<div class="action"> '+ lang.comment+'</div>',
						'<div class="info">',									
                        	'<img src="./resources/images/icons/comment.png"/>{numcommnets}',
						'</div>',                                 
                    '</div>'].join('');
		if(minibar){//si el template  debe de mostrar con minibar
			html.splice(9,1,minibarhtml);			
		}
		else{			
			html.splice(0,1,'<div class="comment comments-background">');
		}
        this.callParent(html);
    }
});