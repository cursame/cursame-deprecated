/**
 * @class Cursame.view.surveys.SurveyList
 * @extends Ext.List
 * This component lists the Surveys
 */
Ext.define("Cursame.view.users.UserContainer",{extend:"Ext.List",xtype:"usercontainer",requires:["Cursame.view.users.UserTpl"],config:{store:"Surveys",masked:{xtype:"loadmask",message:lang.loading},scrollable:{direction:"vertical",directionLock:!0},itemTpl:Ext.create("Cursame.view.users.UserTpl",!1)}});