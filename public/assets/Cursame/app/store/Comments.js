/**
 * @class Cursame.store.Comments
 * @extends Ext.data.Store
 * This is the Comments store of Cursame
 */
Ext.define('Cursame.store.Comments', {
    extend: 'Core.data.Store',
	requires: ['Cursame.model.Comment'],
    
    config: {
        model: 'Cursame.model.Comment',
		pageSize: 10
    }
});