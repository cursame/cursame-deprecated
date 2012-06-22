/**
 * @class Cursame.view.discussions.DiscussionTpl
 * @extends Ext.XTemplate
 *
 * This is the xtemplate for the Discussions
 *
 * @manduks april 2012
 */
Ext.define("Cursame.view.discussions.DiscussionTpl",{extend:"Ext.XTemplate",constructor:function(a){var b=['<div class="comment fill-container">','<div class="img">','<img src="'+Cursame.Path+'/assets/course_small.png" />',"</div>",'<div class="contenido">','<div class="title">{title}</div>','<div class="text">',"{description}","</div>","</div>","</div>"];a&&b.splice(0,1,'<div class="course">'),this.callParent(b)}});