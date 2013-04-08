/**
 * @class Cursame.view.courses.CourseMenu
 * @extends Ext.Container
 * Menu que muestra las opciones posibles de los cursos
 */
Ext.define('Cursame.view.courses.CourseMenu', {
    extend: 'Ext.Container',
    xtype: 'coursemenu',
    config: {
        defaults:{
			xtype:'container',
			flex:1,
			layout:'hbox',
			defaults:{				
				flex:2,
				margin: 5
			}
		},
		layout:'vbox',
		items:[{			
			flex:2,
			xtype:'container',
			tpl:Ext.create('Ext.XTemplate',
					'<div class="course">',
						'<div class="left">',
							'<div class="img"><img src="'+Cursame.Path+'/assets/course_small_movistar.jpg" /></div>',
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
					'</div>')
		},{	
			xtype:'toolbar',
			docked: 'bottom',
			ui:'accept',
			//layout:'hbox',				
			items:[{
					xtype:'button',
					iconCls:'chat',
					ui:'accept',
					action:'wall',
					text:lang.wall,
					iconAlign:'left',					
					iconMask:true
				},{
					xtype:'button',
					iconCls:'attachment',
					ui:'accept',
					text:lang.assignments,
					action:'assignments',
					iconAlign:'left',
					iconMask:true
				},{
					xtype:'button',
					iconCls:'check_black1',
					ui:'accept',
					text:lang.surveys,
					action:'surveys',
					iconAlign:'left',
					iconMask:true
				}/*,{
					xtype:'button',
					iconCls:'chat',
					ui:'accept',
					badgeText:lang.discussions,
					iconAlign:'bottom',
					badgeCls:'menu-badge',
					action:'discussions',		
					iconMask:true
				},{
					xtype:'component',
					iconCls:'calendar',
					ui:'accept',
					badgeText:lang.calendar,
					iconAlign:'bottom',
					badgeCls:'menu-badge',
					action:'calendar',				
					iconMask:true
				},{
					xtype:'button',
					iconCls:'team1',
					ui:'accept',
					badgeText:lang.members,
					iconAlign:'bottom',
					badgeCls:'menu-badge',
					action:'members',				
					iconMask:true
				}*/]
		}]
    }
});