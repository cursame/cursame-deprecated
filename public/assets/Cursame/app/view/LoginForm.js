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
			backGroundColor:'#005C84'
		},
		items:[{
			xtype:'image',
			margin : '30 0 0 0',
			height:80,
			src: Cursame.src+'resources/images/movistar.png'
		},{			
			xtype:'image',
			layout:'hbox',
			height: 48,
			src: Cursame.src+'resources/images/experto-text.png'
				
		},{
			xtype:'fieldset',
			defaults:{
				 required: true
			},
			items:[{
				xtype:'emailfield',
				name:'email',
				placeHolder :lang.email,
				clearIcon: true
			},{
				xtype:'passwordfield',
				name:'password',
				value:'merol7',
				clearIcon: true
			}]
		},	{			
					xtype:'fieldset',
					items:[{
						xtype:'button',
						text:'<div class = "movi-color">'+lang.login+'</div>',
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
										localStorage.setItem("User", Ext.encode(op._response.response.user));
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