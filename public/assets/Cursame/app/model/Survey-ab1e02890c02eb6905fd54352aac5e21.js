/**
 * @class Cursame.model.Survey
 * @extends Ext.data.model
 * model for Surveys
 */
Ext.define("Cursame.model.Survey",{extend:"Ext.data.Model",config:{fields:[{name:"id",type:"int"},{name:"course_id",type:"int"},{name:"name",type:"string"},{name:"description",type:"string"},{name:"value",type:"int"},{name:"period",type:"int"},{name:"due_to",type:"date",dateFormat:"c",convert:function(a,b){return Ext.Date.format(new Date(a),"d-m-Y, g:i a")}},{name:"start_at"},{name:"state"}],proxy:{type:"jsonp",url:Cursame.Url+"api/surveys.json",reader:{type:"json",rootProperty:"surveys"}}}});