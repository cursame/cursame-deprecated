/**
 * @class Cursame.controller.phone.Main
 * @extends Cursame.controller.Main
 * Main controller of the phone version
 */
Ext.define('Cursame.controller.phone.Main', {
    extend: 'Cursame.controller.Main',
    
    config: {
        refs: {
			main:'main',
			tabPanel:'main tabpanel'
        },
        control: {
            'main loginform':{
				login:'onLogin'
			}
        }
    },	
	init:function(){
		this.callParent();
	},
	onLogin:function(form){
		this.callParent();
		var tabPanel = this.getTabPanel();
		this.getMain().setActiveItem(tabPanel);
	}
});