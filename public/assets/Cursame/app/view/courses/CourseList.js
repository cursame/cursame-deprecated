/**
 * @class Cursame.view.course.CourseList
 * @extends Ext.List
 * This component show the list of courses in cursame app
 */
Ext.define('Cursame.view.courses.CourseList', {
    extend: 'Ext.List',
	xtype:'courselist',
    
    config: {
        store:'Courses',
		masked:{
		    xtype: 'loadmask',
		    message: lang.loading
		},
		scrollable: {
		    direction: 'vertical',
		    directionLock: true
		},
		plugins: [
            'pullrefresh',
            {
                type: 'listpaging',
                autoPaging: true
            }
        ],
		itemTpl: Ext.create('Ext.XTemplate',
				'<div class="comment ">',
					'<div class="img">',
		            	'<img src="'+Cursame.Path+'/assets/course_small.png" />',
					'</div>',
		            '<div class="contenido">',
		            	'<div class="title">{name}</div>',
		                '<div class="text">',
		                 	'{description}',
		                '</div>',
		                    '<!-- minibar -->',//aqui va el minibar cuando se necesite y es la posicion nueve del arreglo
		            '</div>',
		        '</div>')
    }
});