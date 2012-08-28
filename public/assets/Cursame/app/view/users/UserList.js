/**
 * @class Cursame.view.users.UserList
 * @extends Object
 * This component lists the users
 */
Ext.define('Cursame.view.users.UserList', {
    extend: 'Ext.List',
	xtype:'userslist',
    
    config: {
        store:'Users',
		masked:{
		    xtype: 'loadmask',
		    message: lang.loading
		},
		scrollable: {
		    direction: 'vertical',
		    directionLock: true
		},
        disclosure: true,
        grouped: true,
		indexBar: true,
		itemTpl: Ext.create('Ext.XTemplate',
				'<div class="comment ">',
					'<div class="img">',
		            	'<img src="'+Cursame.Path+'/assets/course_small.png" />',
					'</div>',
		            '<div class="contenido">',
		            	'<div class="title">{first_name} {last_name}</div>',
		                '<div class="text">',
		                 	'{role}',
		                '</div>',
		            '</div>',
		        '</div>')
    }
});