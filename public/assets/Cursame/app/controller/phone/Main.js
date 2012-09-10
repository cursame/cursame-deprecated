/**
 * @class Cursame.controller.phone.Main
 * @extends Cursame.controller.Main
 * Main controller of the phone version
 */
Ext.define('Cursame.controller.phone.Main', {
	extend: 'Cursame.controller.Main',

	config: {
		refs: {
			main: 'main',
			tabPanel: 'main tabpanel',
			loginForm:'main loginform'
		},
		control: {
			'main loginform': {
				login: 'onLogin'
			}
		}
	},
	init: function() {
		this.callParent();
	},
	onLogin: function(form) {
		this.callParent();
		var tabPanel = this.getTabPanel();
		this.getMain().setActiveItem(tabPanel);
	},
	launch: function() {		
		var user = Ext.decode(localStorage.getItem("User"));		
		if (user) {
			Cursame.User = Ext.create('Cursame.model.User',{
				id 				: user.id,
				about_me 		: user.about_me,
				token  			: user.authentication_token,
				avatar_file 	: user.avatar_file.small.url,
				birth_date		: user.birth_date,
				email			: user.email,
				facebook_link	: user.facebook_link,
				first_name		: user.first_name,
				last_name		: user.last_name,
				linkedin_link	: user.linkedin_link,
				occupation		: user.occupation,
				role			: lang[user.role],
				studies			: user.studies,
				twitter_link	: user.twitter_link
			});
			this.getMain().setActiveItem(this.getTabPanel());
			this.onLogin();
		}
	}
});
