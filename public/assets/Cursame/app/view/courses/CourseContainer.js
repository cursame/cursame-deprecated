/**
 * @class Cursame.view.courses.CourseContainer
 * @extends Ext.Container
 * Este es el contenedor que muestran el curso y su layout
 */
Ext.define('Cursame.view.courses.CourseContainer', {
    extend: 'Ext.Container',
	xtype:'coursecontainer',
    
    config: {
        tpl : Ext.create('Ext.XTemplate',
				'<div class="course">',
					'<div class="left">',
						'<div class="img"><img src="'+Cursame.Path+'/assets/course_small.png" /></div>',
					'</div>',
					'<div class="properties">',
						'<p>{name}</p>',						
						'<div>',
							/*'<em class="prop">'+lang.startDate+': </em><em class="val">{start_date}</em></br>',
							'<em class="prop">'+lang.endDate+': </em><em class="val">{finish_date}</em>',*/
						'</div>',
						//'<div><em class="prop">'+lang.timee+': </em><em class="val">10</em></div>',
						'<div class="description">{description}</div>',
					'</div>',
					'<div class="boxes">',
						'<div class="box box-1"><em class="val">{owner}</em><br><em class="prop">'+lang.teacher.toUpperCase()+'</em></div>',
						'<div class="box box-2"><em class="val">{members}</em><br><em class="prop">'+lang.members.toUpperCase()+'</em></div>',
					'</div>',					
				'</div>'
				)
    }
});