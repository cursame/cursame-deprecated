/**
 * @class Cursame.view.discussions.DiscussionWall
 * @extends Container
 * Description
 */
Ext.define("Cursame.view.discussions.DiscussionWall",{extend:"Ext.List",xtype:"discussionwall",requires:["Cursame.view.discussions.DiscussionContainer","Cursame.view.comments.CommentTpl","Cursame.view.comments.CommentToolbar"],config:{store:"Comments",masked:{xtype:"loadmask",message:lang.loading},scrollable:{direction:"vertical",directionLock:!0},items:[{xtype:"discussioncontainer"},{xtype:"commentbar"}],itemTpl:Ext.create("Cursame.view.comments.CommentTpl",!0)}});