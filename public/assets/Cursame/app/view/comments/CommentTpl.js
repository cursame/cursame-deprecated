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
	    constructor: function(minibar,numComments) {	
			var html,minibar;		 
	        html = ['<div class="comment ">',
							'<div class="img">',
	                        	'<img src="{userimage}" />',
							'</div>',
	                        '<div class="contenido">',
	                            '<div class="title">{userfirstname} {userlasttname}</div>',
	                            '<div class="text">',
	                                '{text}',
	                            '</div>',
	                             '<div class="minibar"><div class="action">{like}</div></div>',//posicion 9
								'</div>',
	               '</div>'];
			if(numComments){
				minibarhtml = ['<div class="minibar">',
									'<div class="info">',									
			                        	'<img src="./assets/Cursame/resources/images/icons/comment.png"/>{numcommnets}',
									'</div>',                                 
			                    '</div>'].join('');
			}
			else{
				minibarhtml = [		
							'<div class="minibar">',
								'<div class="action">{like}</div>',
								'<div class="info">',									
		                        	'<img src="./assets/Cursame/resources/images/icons/tick.png"/> {numlikes} &nbsp;&nbsp;',lang.comment+' <img src="./assets/Cursame/resources/images/icons/comment.png"/>{numcommnets}',
								'</div>',                                 
		                    '</div>'].join('');
			}		
			if(minibar){//si el template  debe de mostrar con minibar
				html.splice(9,1,minibarhtml);			
			}		
			else{			
				html.splice(0,1,'<div class="comment comments-background">');
			}
	        this.callParent(html);
	    }
	});