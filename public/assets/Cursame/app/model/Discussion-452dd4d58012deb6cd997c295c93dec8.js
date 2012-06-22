/**
 * @class Cursame.model.Discussion
 * @extends Ext.data.model
 * model for Discussion
 */
Ext.define("Cursame.model.Discussion",{extend:"Ext.data.Model",config:{fields:[{name:"id",type:"int"},{name:"course_id",type:"int"},{name:"title",type:"string"},{name:"description",type:"string"},{name:"user_id",type:"int"}],proxy:{type:"jsonp",url:Cursame.Url+"api/discussions.json",reader:{type:"json",rootProperty:"discussions"}}}});