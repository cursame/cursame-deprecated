/**
 * @class Cursame.model.UserLogin
 * @extends Ext.data.model
 * This is the user model of cursame
 */
Ext.define("Cursame.model.UserLogin",{extend:"Ext.data.Model",config:{fields:["id","about_me",{name:"token",mapping:"authentication_token"},"avatar_file","birth_date","email","facebook_link","first_name","last_name","linkedin_link","occupation","role","studies","twitter_link"],proxy:{type:"jsonp",url:Cursame.Url+"tokens/create.json",reader:{type:"json",rootProperty:"response.user"}}}});