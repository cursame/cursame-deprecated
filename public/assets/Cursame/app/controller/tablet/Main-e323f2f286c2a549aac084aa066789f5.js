/**
 * @class Cursame.controller.tablet.Main
 * @extends Cursame.controller.Main
 * Main controller of the tablet version
 */
Ext.define("Cursame.controller.tablet.Main",{extend:"Cursame.controller.Main",config:{refs:{main:"main",panel:"main panel"},control:{"main loginform":{login:"onLogin"}}},init:function(){this.callParent()},onLogin:function(a){this.callParent();var b=this.getPanel();this.getMain().setActiveItem(b)}});