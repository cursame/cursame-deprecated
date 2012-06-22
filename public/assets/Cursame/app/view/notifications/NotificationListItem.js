/**
 * @class Cursame.view.notifications.NotificationListItem
 * @extends Ext.data.component.DataItem
 * This the notitification list item of cursame used to list the notitications components
 */
Ext.define('Cursame.view.notifications.NotificationListItem', {
    extend: 'Ext.dataview.component.DataItem',
    xtype : 'notificationlistitem',
	requieres:[
		'Ext.Img'
	],

    config: {
		ui:'notification',
		dataMap: {
			getUser: {
				setHtml: 'user'
			},
			getText: {
				setHtml: 'text'
			},
			getAvatar: {
				setScr: 'avatar'
			},
			getCreated:{
				setHtml: 'created'
			},
			getDeclineButton:{
				setHidden:'btn'
			},
			getAcceptButton:{
				setHidden:'btn'
			}
		},
		
		user: {
			cls: 'user',
			
		},
		
		text:{
			cls: 'text'
		},
		
		avatar:{
			docked	:'left',
			cls		:'avatar',
			height: 48,
		    width: 48,
			src:Cursame.src+'resources/images/avatar_normal.png'
		},			
		
		declineButton:{
			docked	:'right',
			iconMask:true,		
			cls:'c-button',
			margin:'10 0 0 3',
			iconCls:'delete',			
			ui:'decline',
			accept:false
		},
		acceptButton:{
			docked	:'right',
			iconMask:true,
			cls:'c-button',
			margin:'10 0 0 3',
			iconCls:'check1',
			ui:'small',
			accept:true
		},
		
		created:{
			cls : 'time-ago'
		},		
		
		layout:{
			type:'vbox'
		}
        
    },
	
	applyUser: function(config){
		return Ext.factory(config, Ext.Component, this.getUser());
	},
	updateUser:function(newUser){
		if (newUser) {
            this.insert(0,newUser);
        }
	},
	
	applyText: function(config){
		return Ext.factory(config, Ext.Component, this.getText());
	},
	updateText:function(newText){
		if (newText) {
            this.add(newText);
        }
	},
		
	applyAvatar: function(config) {
        return Ext.factory(config, Ext.Img, this.getAvatar());
    },
	updateAvatar: function(newAvatar) {
        if (newAvatar) {
            this.add(newAvatar);
        }
    },
	
	applyDeclineButton: function(config) {
        return Ext.factory(config, Ext.Button, this.getDeclineButton());
    },
	updateDeclineButton: function(newDeclineButton) {
        if (newDeclineButton) {
            this.add(newDeclineButton);
        }
    },

	applyAcceptButton: function(config) {
        return Ext.factory(config, Ext.Button, this.getAcceptButton());
    },
	updateAcceptButton: function(newAcceptButton) {
        if (newAcceptButton) {
            this.add(newAcceptButton);
        }
    },
	
	applyCreated: function(config) {
        return Ext.factory(config, Ext.Component, this.getCreated());
    },
	updateCreated: function(newCreated) {
        if (newCreated) {
            this.add(newCreated);
        }
    }
	
});