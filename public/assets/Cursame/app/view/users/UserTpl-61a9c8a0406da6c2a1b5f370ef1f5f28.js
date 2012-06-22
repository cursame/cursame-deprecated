/**
 * @class Cursame.view.users.UserTpl
 * @extends Ext.XTemplate
 *
 * This is the xtemplate for the users
 *
 * @manduks april 2012
 */
Ext.define("Cursame.view.users.UserTpl",{extend:"Ext.XTemplate",constructor:function(){var a=['<div class="comment ">','<div class="img">','<img src="'+Cursame.Path+'/assets/course_small.png" />',"</div>",'<div class="contenido">','<div class="title">{first_name} {last_name}</div>','<div class="text">',"{role}","</div>",'<div class="text"><b>'+lang.about_me+"</b> {about_me}</div>",'<div class="text"><b>'+lang.studies+"</b> {studies}</div>",'<div class="text"><b>'+lang.occupation+"</b> {occupation}</div>",'<div class="title">@{twitter_link}</div>',"</div>","</div>"];this.callParent(a)}});