/**
 * @class Cursame.store.TopUsers
 * @extends Core.data.Store
 * Store for top users
 * @manduks
 */
Ext.define('Cursame.store.TopUsers', {
    extend: 'Core.data.Store',
	requires: ['Cursame.model.TopUser'],
    
    config: {
        model: 'Cursame.model.TopUser',
		//setup the grouping functionality to group by the first letter of the firstName field
        grouper: {
            groupFn: function(record) {
                return record.get('last_name')[0].toUpperCase();
            }
        },
		pageSize: 100,
		//filter the data using the firstName field
        sorters: 'last_name'
    }
});
