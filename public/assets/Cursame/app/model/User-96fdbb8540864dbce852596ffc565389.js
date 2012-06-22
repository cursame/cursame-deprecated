/**
 * @class Cursame.model.User
 * @extends Ext.data.model
 * This is the user model of cursame
 */
Ext.define("Cursame.model.User",{extend:"Ext.data.Model",config:{fields:["id","about_me",{name:"token",mapping:"authentication_token"},"avatar_file","birth_date","email","facebook_link","first_name","last_name","linkedin_link","occupation",{name:"role",convert:function(a,b){return lang[a]}},"studies","twitter_link"],proxy:{type:"jsonp",url:Cursame.Url+"api/users.json",reader:{type:"json",rootProperty:"users"}}}});