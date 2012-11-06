/**
 * @class Cursame.store.Users
 * @extends Core.data.Store
 * Store for users
 */
Ext.define('Cursame.store.Users', {
    extend: 'Core.data.Store',
	requires: ['Cursame.model.User'],
    
    config: {
        model: 'Cursame.model.User',
		//setup the grouping functionality to group by the first letter of the firstName field
        grouper: {
            groupFn: function(record) {
                return record.get('last_name')[0].toUpperCase();
            }
        },
		pageSize: 20,
		//filter the data using the firstName field
        sorters: 'last_name'
    }
});
