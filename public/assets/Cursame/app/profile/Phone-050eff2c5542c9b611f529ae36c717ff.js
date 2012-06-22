/**
 * @class Cursame.profile.Phone
 * @extends Ext.app.Profile
 * This is the phone profile
 */
Ext.define("Cursame.profile.Phone",{extend:"Ext.app.Profile",config:{name:"phone",namespace:"phone",controllers:["Main"],views:["Main"]},isActive:function(){return Ext.os.is.Phone},launch:function(){Ext.create("Cursame.view.phone.Main")}});