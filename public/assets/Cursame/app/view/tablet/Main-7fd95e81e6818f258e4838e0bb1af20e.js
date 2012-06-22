/**
 * @class Cursame.view.tablet.Main
 * @extends Cursame.view.Main
 * This is the main class for our tablet application
 */
Ext.define("Cursame.view.tablet.Main",{extend:"Cursame.view.Main",config:{layout:"card",items:[{xtype:"container",layout:"hbox",padding:"120 15 15 0",items:[{xtype:"container",flex:1},{xtype:"loginform",width:400,scrollable:!1,tablet:!0,listeners:{masking:function(a){a.setMasked(!1),this.up("container").setMasked({xtype:"loadmask",message:lang.starting})},error:function(a,b){a.setMasked(!1),this.up("container").setMasked({xtype:"loadmask",message:b}),setTimeout(function(){a.setMasked(!1)},1e3)},unmasking:function(a){var b=this.up("container");b.setMasked(!1),setTimeout(function(){b.setMasked(!1)},1e3)}}},{xtype:"container",flex:1}]},{xtype:"panel",layout:"hbox",items:[{title:"menu",style:"background-color: #00282E;",flex:1},{xtype:"notificationnavigationview",title:language.home,flex:4}]}]}});