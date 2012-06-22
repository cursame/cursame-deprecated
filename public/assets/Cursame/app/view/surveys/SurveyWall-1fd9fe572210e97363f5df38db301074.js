/**
 * @class Cursame.view.surveys.SurveyWall
 * @extends Container
 * Description
 */
Ext.define("Cursame.view.surveys.SurveyWall",{extend:"Ext.List",xtype:"surveywall",requires:["Cursame.view.surveys.SurveyContainer","Cursame.view.comments.CommentTpl","Cursame.view.comments.CommentToolbar"],config:{store:"Comments",masked:{xtype:"loadmask",message:lang.loading},scrollable:{direction:"vertical",directionLock:!0},items:[{xtype:"surveycontainer"},{xtype:"commentbar"}],itemTpl:Ext.create("Cursame.view.comments.CommentTpl",!0)}});