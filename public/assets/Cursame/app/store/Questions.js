/**
 * @class Cursame.store.Questions
 * @extends Core.data.Store
 * This is the Surveys store of Cursame
 */
Ext.define('Cursame.store.Questions', {
    extend: 'Core.data.Store',
	requires: ['Cursame.model.Question'],
    
    config: {
        model: 'Cursame.model.Question'
    }
});