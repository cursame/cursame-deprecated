/**
 * @class Cursame.view.comments.CommentWall
 * @extends Object
 * Description
 */
Ext.define("Cursame.view.comments.CommentWall",{extend:"Ext.List",xtype:"commentwall",requires:["Cursame.view.comments.CommentContainer","Cursame.view.comments.CommentTpl","Cursame.view.comments.CommentToolbar"],config:{store:"CommentsComments",masked:{xtype:"loadmask",message:lang.loading},scrollable:{direction:"vertical",directionLock:!0},items:[{xtype:"commentcontainer"},{xtype:"commentbar"}],itemTpl:Ext.create("Cursame.view.comments.CommentTpl",!1)}});