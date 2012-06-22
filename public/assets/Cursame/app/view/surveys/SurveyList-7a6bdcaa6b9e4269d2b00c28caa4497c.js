/**
 * @class Cursame.view.surveys.SurveyList
 * @extends Ext.List
 * This component lists the Surveys
 */
Ext.define("Cursame.view.surveys.SurveyList",{extend:"Ext.List",xtype:"surveyslist",requires:["Cursame.view.surveys.SurveyTpl"],config:{store:"Surveys",masked:{xtype:"loadmask",message:lang.loading},scrollable:{direction:"vertical",directionLock:!0},itemTpl:Ext.create("Cursame.view.surveys.SurveyTpl",!1)}});