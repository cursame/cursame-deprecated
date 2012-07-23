/**
 * @class Cursame.store.Courses
 * @extends Object
 * 
 */
Ext.define('Cursame.store.Courses', {
    extend: 'Core.data.Store',
	requires: ['Cursame.model.Course'],
    
    config: {
        model: 'Cursame.model.Course'
    }
});