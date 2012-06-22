/**
 * @class Cursame.store.Users
 * @extends Core.data.Store
 * Store for users
 */
Ext.define("Cursame.store.Users",{extend:"Core.data.Store",requires:["Cursame.model.User"],config:{model:"Cursame.model.User",grouper:{groupFn:function(a){return a.get("first_name")[0]}},sorters:"first_name"}});