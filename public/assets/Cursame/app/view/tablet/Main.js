/**
 * @class Cursame.view.tablet.Main
 * @extends Cursame.view.Main
 * This is the main class for our tablet application
 */
Ext.define('Cursame.view.tablet.Main', {
    extend: 'Cursame.view.Main',
	config: {
        layout: 'card',
        items: [{
			xtype:'container',
			layout:'hbox',
			padding:'120 15 15 0',
			items:[{
					xtype:'container',						
					flex:1					
				},{
					xtype:'loginform',				
					width: 400,					
					scrollable:false,
					tablet:true,
					listeners:{
						masking:function(form){
							form.setMasked(false);
							this.up('container').setMasked({
		                        xtype: 'loadmask',
		                        message: lang.starting
		                    });
						},
						error:function(form,msg){
							form.setMasked(false);
							this.up('container').setMasked({
		                        xtype: 'loadmask',
		                        message: msg
		                    });
							setTimeout(function() {
								form.setMasked(false);
							}, 1000);
						},
						unmasking:function(form){
							var cmp = this.up('container');
							cmp.setMasked(false);
							setTimeout(function() {
								cmp.setMasked(false);
							}, 1000);
						}
					}
				},{
					xtype:'container',
					flex:1
				}]
		},{
			xtype:'panel',
			layout:'hbox',
			items:[{
				title:'menu',
				style:'background-color: #00282E;',
				flex:1,
				
			},{
				xtype:'notificationnavigationview',
				title:language.home,
				flex:4
			}]
		}]
    }
});