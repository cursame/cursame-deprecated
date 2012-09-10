/**
 * @class Cursame.view.network.NetworkNavigationView.js
 * @extends Ext.navigation.View
 * The navigation view of the cursame network, this is to navigate between the cursame network wall
 * @author @manduks 
 */
Ext.define('Cursame.view.network.NetworkNavigationView', {
    extend: 'Ext.navigation.View',
	xtype:'networknavigationview',
    
	requires:[
			'Cursame.view.network.NetworkWall'
	],
    config: {
		items:{
			xtype: 'networkwall',
			title: lang.wall
		},
        navigationBar: {
		            items: [{
						align: 'left',
						text:lang.sign_out,
						itemId:'signOut',
						handler:function(){
							localStorage.removeItem('User');				
						}
					}/*,{
		                    iconCls: 'cursame',
		                    iconMask: true,
		                    ui: 'plain',
		                    align: 'right'
		                }*/
		            ],
		        }
    },
 	applyLayout: function(config) {
        config = config || {};
        if (Ext.os.is.Android) {
            config.animation = false;
        }
        return config;
    }
});