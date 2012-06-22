/**
 * @class Cursame.view.phone.Main
 * @extends Cursame.view.Main
 * This is the main class for our iphone application
 */
Ext.define("Cursame.view.phone.Main",{extend:"Cursame.view.Main",requires:["Ext.tab.Panel","Cursame.view.users.UserNavigationView"],config:{layout:"card",items:[{xtype:"loginform",scrollable:!1},{xtype:"tabpanel",fullscreen:!0,activeItem:0,tabBarPosition:"bottom",items:[{xtype:"notificationnavigationview",iconCls:"info"},{xtype:"coursenavigationview",iconCls:"docs2"},{xtype:"usernavigationview",type:"user",iconCls:"user_list2"}]}]}});