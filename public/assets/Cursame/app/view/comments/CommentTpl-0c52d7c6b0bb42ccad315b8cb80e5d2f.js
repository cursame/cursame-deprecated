/**
 * @class Cursame.view.comments.CommentTpl
 * @extends Ext.XTemplate
 *
 * This is the xtemplate for the comments
 *
 * @manduks april 2012
 */
Ext.define("Cursame.view.comments.CommentTpl",{extend:"Ext.XTemplate",constructor:function(a){var b,a;b=['<div class="comment ">','<div class="img">','<img src="'+Cursame.Path+'/assets/course_small.png" />',"</div>",'<div class="contenido">','<div class="title">{userfirstname} {userlasttname}</div>','<div class="text">',"{text}","</div>","<!-- minibar -->","</div>","</div>"],minibarhtml=['<div class="minibar">','<div class="action"> '+lang.comment+"</div>",'<div class="info">','<img src="./resources/images/icons/comment.png"/>{numcommnets}',"</div>","</div>"].join(""),a?b.splice(9,1,minibarhtml):b.splice(0,1,'<div class="comment comments-background">'),this.callParent(b)}});