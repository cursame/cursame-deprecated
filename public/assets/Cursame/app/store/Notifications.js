/**
 * @class Cursame.store.Notifications
 * @extends Ext.data.Store
 * This is the Notifications store of Cursame
 */
Ext.define('Cursame.store.Notifications', {
    extend: 'Core.data.Store',
	requires: ['Cursame.model.Notification'],
    
    config: {
        model: 'Cursame.model.Notification',
		sorters: [
	        {
	            property : 'created',
	            direction: 'DESC'
	        }
	    ]
    }
});