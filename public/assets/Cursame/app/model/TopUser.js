/**
 * @class Cursame.model.TopUser
 * @extends Ext.data.model
 * This is the top users model of cursame
 */
Ext.define('Cursame.model.TopUser', {
    extend: 'Ext.data.Model',
    
    config: {
        fields:[
			'id',
			'about_me',
			{name:'token', mapping:'authentication_token'},
			{name:'avatar_file', mapping:'avatar_file.small.url'},
			'birth_date',
			'email',
			'facebook_link',
			{
				name:'first_name', convert:function(value){
					return value.toLocaleUpperCase();
				}
			},
			{
				name:'last_name', convert:function(value,record){
					return value.toLocaleUpperCase();
				}
			},
			'linkedin_link',
			'occupation',
			{
				name:'role',convert:function(value,record){
					return lang[value];
				}
			},
			'studies',
			'twitter_link'			
		],
		proxy:{
			type:'jsonp',
			url:Cursame.Url+'api/topusers.json',
			reader:{
				type:'json',
				rootProperty:'users'
			}			
		}
    }
});