/**
 * @class Cursame.model.Course
 * @extends Ext.data.model
 * model for courses
 */
Ext.define("Cursame.model.Course",{extend:"Ext.data.Model",config:{fields:[{name:"id",type:"int"},{name:"name",type:"string"},{name:"description",type:"string"},{name:"image",type:"string"},{name:"public",type:"boolean"},{name:"owner",type:"string"},{name:"members",type:"int"},{name:"start_date"},{name:"finish_date"}],proxy:{type:"jsonp",url:Cursame.Url+"api/courses.json",reader:{type:"json",rootProperty:"courses"}}}});