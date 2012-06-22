/**
 * @class Cursame.profile.Tablet
 * @extends Ext.app.Profile
 * This is the ipad profile
 */
Ext.define('Cursame.profile.Tablet', {
    extend: 'Ext.app.Profile',
    
    config: {
        name:'tablet',
		namespace:'tablet',
		controllers:['Main'],
		views:['Main']
    },
	
	isActive: function(){
		return !Ext.os.is.Phone;
	},
	
	launch: function(){
		Ext.create('Cursame.view.tablet.Main');
	}
});