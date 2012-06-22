/**
 * @class Cursame.store.Assignments
 * @extends Ext.data.Store
 * This is the Assignments store of Cursame
 */
Ext.define('Cursame.store.Assignments', {
    extend: 'Core.data.Store',
	requires: ['Cursame.model.Assignment'],
    
    config: {
        model: 'Cursame.model.Assignment'
    }
});