/**
 * @class Cursame.model.User
 * @extends Ext.data.model
 * This is the user model of cursame
 */
Ext.define('Cursame.model.User', {
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
			'first_name',
			'last_name',
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
			url:Cursame.Url+'api/users.json',
			reader:{
				type:'json',
				rootProperty:'users'
			}			
		}
    }
});