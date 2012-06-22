/**
 * @class Cursame.store.Discussions
 * @extends Core.data.Store
 * This is the Discussions store of Cursame
 */
Ext.define('Cursame.store.Discussions', {
    extend: 'Core.data.Store',
	requires: ['Cursame.model.Discussion'],
    
    config: {
        model: 'Cursame.model.Discussion'
    }
});