/**
 * @class Core.data.Store
 * @extends Ext.data.Store
 * This is the Notifications store of Cursame
 */
Ext.define("Core.data.Store",{extend:"Ext.data.Store",config:{listeners:{beforeload:function(a,b,c){a.getProxy().setExtraParam("auth_token",Cursame.User.get("token"))}}}});