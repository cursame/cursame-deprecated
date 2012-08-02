/**
 * @class MyNamespace.LoginForm
 * @extends Object
 * Description
 */
Ext.define('Cursame.view.LoginForm', {
    extend: 'Ext.form.Panel',
    xtype:'loginform',	

	requires:[
		'Ext.form.FieldSet',
		'Ext.field.Email',
		'Ext.field.Password',
		'Ext.Img',
		'Cursame.model.UserLogin'
	],
	
    config: {
		ui:'login',
        padding:'15 15 15 15',
		style:{
			backGroundColor:'#FFF'
		},
		items:[{
			xtype:'container',
			height:70,
		},{			
				xtype:'container',
				layout:'hbox',
				height: 64,
				items:[{
						xtype:'container',						
						flex:1					
					},{
						xtype:'image',
						padding:'15 15 15 15',	
						src: Cursame.src+'resources/images/cursa.png',						
						width: 150
				},{
						xtype:'container',
						flex:1
				}]
		},{
			xtype:'fieldset',
			defaults:{
				 required: true,
			},
			items:[{
				xtype:'emailfield',
				name:'email',
				placeHolder :lang.email,
				value:'maestro@cursa.me',
				//value:'alumno@cursa.me',	
				clearIcon: true
			},{
				xtype:'passwordfield',
				name:'password',
				placeHolder:lang.password,
				value:'maestrocursame7',
				//value:'alumnocursame7',
				clearIcon: true
			}]
		},	{			
					xtype:'fieldset',
					items:[{
						xtype:'button',
						text:lang.login,
						ui:'accept',
						handler: function(btn) {
							var form,obj;
							form = this.up('formpanel');
							obj = form.getValues(),form;				
							
							form.setMasked({
		                        xtype: 'loadmask',
		                        message: lang.starting
		                    });				
							//para el ipad utilizamos otro tipo de masking
							form.fireEvent('masking',form);
							
						  	Cursame.model.UserLogin.load(888,{
								params:{
									email:obj.email,
									password:obj.password
								},
								success:function(record,op){
									form.setMasked(false);
									//para el ipad utilizamos otro tipo de masking
									form.fireEvent('unmasking',form);
									
									if(record){ //si existe el usuario
										Cursame.User = record;
										form.fireEvent('login', form);
									}
									else{
										form.setMasked({
					                        xtype: 'loadmask',
					                        message: op._response.response.message
					                    });
										//para el ipad utilizamos otro tipo de masking
										form.fireEvent('error',form,op._response.response.message);
										
										setTimeout(function() {
											form.setMasked(false);
										}, 1000);
									}
								}
							});
						}
					}]
			}]
    }
});