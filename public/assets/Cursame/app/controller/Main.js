Ext.define('Cursame.controller.Main', {
    extend: 'Ext.app.Controller',
	
	config:{
		refs:{
			main:{
				selector:'mainview'
			},
			notificationsList:'notificationslist',
			notificationNavigationView:'notificationnavigationview',
			courseContainer:'coursecontainer',
			commentContainer:'commentcontainer',
			courseWall:'coursewall',
			commentWall:'commentwall',
			commentWallButton:'commentwall toolbar button',
			commentWallTextfield:'commentwall toolbar textfield',
			courseWallButton:'coursewall toolbar button',
			courseWallTextfield:'coursewall toolbar textfield',
			courseNavigationView:'coursenavigationview',
			courseList:'coursenavigationview courselist',
			courseMenu:'coursemenu',
			tabPanel:'tabpanel',
			surveyWall:'surveywall',
			assignmentWall:'assignmentwall',
			assignmentContainer:'assignmentcontainer',
			assignmentWallTextfield:'assignmentwall toolbar textfield',
			discussionWall:'discussionwall',
			discussionContainer:'discussioncontainer',
			discussionWallTextfield:'discussionwall toolbar textfield',
			userWall:'usernavigationview userwall',
			userNavigationView:'usernavigationview'
		},
		control:{
			'notificationslist notificationlistitem button':{
				tap:'onNotificationButtonTap'
			},
			notificationslist:{
				itemtap:'onNotificationTap'
			},
			coursewall:{
				itemtap:'onCourseWallTap'
			},
			'commentwall commentbar button':{
				tap:'onCommentWallPost'
			},
			'coursewall commentbar button':{
				tap:'onCourseWallPost'
			},
			'commentwall commentbar textfield':{
				change:'onCommentWallTextfieldChange'
			},
			'coursewall commentbar textfield':{
				change:'onCourseWallTextfieldChange'
			},
			'coursenavigationview':{
				activate:'onCourseListPaint'
			},
			'coursenavigationview courselist':{
				itemtap:'onCourseTap'
			},
			'coursenavigationview coursemenu button':{
				tap:'onCourseMenuTap'
			},
			'tabpanel':{
				activeitemchange:'onTabPanelChange'
			},
			/*generic behavior for comments button*/
			'commentbar textfield':{
				change:'onCommentFieldChange'
			},
			/*members*/
			'coursenavigationview userslist':{
				itemtap:'onUsersListTap'
			},
			/*assignments*/
			'coursenavigationview assignmentslist':{
				itemtap:'onAssignmentsListTap'
			},
			'assignmentwall commentbar button':{
				tap:'onAssignmentWallPost'
			},
			'assignmentwall':{
				itemtap:'onAssignmentWallTap'
			},
			/*surveys*/
			'coursenavigationview surveyslist':{
				itemtap:'onSurveysListTap'
			},
			'coursenavigationview surveywall':{},
			/*discussions*/
			'coursenavigationview discussionslist':{
				itemtap:'onDiscussionsListTap'
			},
			'discussionwall commentbar button':{
				tap:'onDiscussionWallPost'
			},
			'discussionwall':{
				itemtap:'onDiscussionWallTap'
			},
		}
	},
    launch:function(){},
	onLogin:function(form){
		var store = Ext.getStore('Notifications');
		store.load();
	},
	onNotificationButtonTap:function(button,e){	
		var item   = button.getParent(),
            record = item.getRecord();
			
		this.maskComponent(this.getNotificationsList());
		
		Cursame.ajax({
        	url:'api/course_requests',
			scope:this,
            params:{
            	id:record.data.notificator_id,
                accept:button.config.accept
            },
            success:function (response) {
            	Ext.getStore('Notifications').load({
		            callback:this.onNotificationsStoreLoad,
		            scope:this
		        });
            }
        });
	},
	onNotificationsStoreLoad:function(){	
		this.getNotificationsList().setMasked(false);
	},
	onNotificationTap:function(dataview,index,target,record,e){
		var type = record.get('kind');
		if(type === 'student_assignment_delivery' || type === 'teacher_survey_replied'){ // si trata de una entrega de la tarea
			Ext.Msg.alert('Cursame', 'Para aprovechar esta función por favor utiliza Cúrsame desde una computadora o tablet.', Ext.emptyFn);			
			return;
		}
			
		if(type === 'user_comment_on_course'){			
			this.getNotificationNavigationView().push({xtype:'coursewall' ,title:record.data.courseObject.name});				
			this.loadStore(Ext.getStore('Comments'),{
					id:record.get('course_id'),
					type:'Course'
				},undefined);
			var courseObject = record.get('courseObject'),
				courseOwner = record.get('courseOwner');			
			var course = Ext.create('Cursame.model.Course', {
					id:courseObject.id,
					name:courseObject.name,
					description:courseObject.description,
					image:courseObject.logo_file,
					'public':courseObject.public,
					start_date:courseObject.start_date,
					finish_date:courseObject.finish_date,
					owner:courseOwner.first_name + ' ' + courseOwner.last_name,
					members:record.get('courseMembers')
				});			
			this.getCourseContainer().setRecord(course);
		}	
	},
	maskComponent:function(cmp){
		cmp.setMasked({
			xtype: 'loadmask',
			message: lang.loading
		});
	},
	onCourseWallTap:function(dataview,index,target,record,e,opt){
		 if (e.getTarget('div.minibar')) {	
			if(this.getNotificationNavigationView().getItems().length === 3){//si se tiene que agregar a notificaciones el commentwall
				this.getNotificationNavigationView().push({ xtype:'commentwall',title: lang.comments});
			}else{//si se tiene que agregar a curso
				this.getCourseNavigationView().push({xtype:'commentwall' ,title:lang.comments});
			}			
			this.loadStore(Ext.getStore('CommentsComments'),{
					id:record.get('id'),
					type:'Comment'
				},undefined);
			this.getCommentContainer().setRecord(record);
	     }
	},
	loadStore:function(store,params,callback){
		store.load({
            callback:callback,
			params:params,
            scope:this
        });
	},
	loadCommentsStore: function(store){
		
	},
	onCommentWallTextfieldChange:function(textfield,nval,oval,o){
		this.getCommentWallButton().setDisabled(nval.replace(/ /g,'') == '');
	},
	onCourseWallTextfieldChange:function(textfield,nval,oval,o){
		this.getCourseWallButton().setDisabled(nval.replace(/ /g,'') == '');		
	},
	onCommentWallPost:function(btn){
		var record = this.getCommentContainer().getRecord();
		this.saveComment('Comment',this.getCommentWallTextfield(),btn,record.get('id'),Ext.getStore('CommentsComments'));
	},
	onCourseWallPost:function(btn){
		var record = this.getCourseContainer().getRecord();
		this.saveComment('Course',this.getCourseWallTextfield(),btn,record.get('id'),Ext.getStore('Comments'));
	},
	onAssignmentWallPost:function(btn){
		var record = this.getAssignmentContainer().getRecord();
		this.saveComment('Assignment',this.getAssignmentWallTextfield(),btn,record.get('id'),Ext.getStore('Comments'));
	},
	onDiscussionWallPost:function(btn){
		var record = this.getDiscussionContainer().getRecord();
		this.saveComment('Discussion',this.getDiscussionWallTextfield(),btn,record.get('id'),Ext.getStore('Comments'));
	},
	saveComment:function(type,textfield,btn,comentableId,store){
		btn.disable();
		Cursame.ajax({
        	url:'api/create_comment',
			scope:this,			
            params:{            
					commentable_type:type,
                	commentable_id:comentableId,					
					text:textfield.getValue()
            },
            success:function (response) {
            	this.loadStore(store,{
						id:comentableId,
						type:type
					},function(){textfield.reset();});
            }
        });
	},
	onCourseListPaint:function(view){
		Ext.getStore('Courses').load();
	},
	onCourseTap: function(dataview,index,target,record,e,opt){
		this.getCourseNavigationView().push({ xtype:'coursemenu',title: record.get('name')});
		this.getCourseMenu().items.items[0].setRecord(record);
	},
	onCourseMenuTap:function(btn){
		var courseContainer = btn.up('container').up('container'),
			courseItems = courseContainer.items.items,
			courseRecord = courseItems[0].getRecord();
			btn.disable();
		switch(btn.action){
			case 'wall': 
				this.getCourseNavigationView().push({xtype:'coursewall' ,title:courseRecord.get('name')});
				this.loadStore(Ext.getStore('Comments'),{
						id:courseRecord.get('id'),
						type:'Course'
					},undefined);
				this.getCourseContainer().setRecord(courseRecord);
			break;
			case 'members':
				this.getCourseNavigationView().push({xtype:'userslist' ,title:lang.members});
				this.loadStore(Ext.getStore('Users'),{
						id:courseRecord.get('id'),
						type:'Course'
					},undefined);
			break;
			case 'assignments':
				this.getCourseNavigationView().push({xtype:'assignmentslist' ,title:lang.assignments});
				this.loadStore(Ext.getStore('Assignments'),{
						id:courseRecord.get('id')
					},undefined);
			break;
			case 'surveys':
				this.getCourseNavigationView().push({xtype:'surveyslist' ,title:lang.surveys});
				this.loadStore(Ext.getStore('Surveys'),{
						id:courseRecord.get('id')
					},undefined);
			break;
			case 'discussions':
				this.getCourseNavigationView().push({xtype:'discussionslist' ,title:lang.discussions});
				this.loadStore(Ext.getStore('Discussions'),{
						id:courseRecord.get('id')
					},undefined);
			break;
		}
		btn.enable();
	},
	/*solo para el telefono*/
	onTabPanelChange:function(tabpanel,value,oldValue,opts){
		var cuantos = oldValue.getItems().length;
		oldValue.pop(cuantos - 1 );
		if(value.type === 'user'){
			this.getUserNavigationView().push({ xtype:'userwall',title: Cursame.User.get('first_name') +' '+Cursame.User.get('last_name') });
			this.loadStore(Ext.getStore('Users'),{				
					type:'Profile'
				},undefined);
			//this.getUserWall().items.items[0].setRecord(Cursame.User);
		}
	},
	/*members*/
	onUsersListTap:function(){
		//alert(888);
	},
	/*assignments*/
	onAssignmentsListTap:function(dataview,index,target,record,e,opt){
		this.getCourseNavigationView().push({ xtype:'assignmentwall',title: record.get('name')});
		this.loadStore(Ext.getStore('Comments'),{
				id:record.get('id'),
				type:'Assignment'
			},undefined);
		this.getAssignmentWall().items.items[0].setRecord(record);
	},
	onAssignmentWallTap:function(dataview,index,target,record,e,opt){
		if (e.getTarget('div.minibar')) {			
			this.getCourseNavigationView().push({xtype:'commentwall' ,title:lang.comments});
			this.loadStore(Ext.getStore('CommentsComments'),{
					id:record.get('id'),
					type:'Comment'
				},undefined);
			this.getCommentContainer().setRecord(record);
	     }
	},
	/*surveys*/
	onSurveysListTap:function(dataview,index,target,record,e,opt){
		this.getCourseNavigationView().push({ xtype:'surveywall',title: record.get('name')});
		this.loadStore(Ext.getStore('Comments'),{
				id:record.get('id'),
				type:'Survey'
			},undefined);
		this.getSurveyWall().items.items[0].setRecord(record);
	},
	/*discussions*/
	onDiscussionsListTap:function(dataview,index,target,record,e,opt){
		this.getCourseNavigationView().push({ xtype:'discussionwall',title: record.get('name')});
		this.loadStore(Ext.getStore('Comments'),{
				id:record.get('id'),
				type:'Discussion'
			},undefined);
		this.getDiscussionWall().items.items[0].setRecord(record);
	},
	onDiscussionWallTap:function(dataview,index,target,record,e,opt){
		if (e.getTarget('div.minibar')) {			
			this.getCourseNavigationView().push({xtype:'commentwall' ,title:lang.comments});
			this.loadStore(Ext.getStore('CommentsComments'),{
					id:record.get('id'),
					type:'Comment'
				},undefined);
			this.getCommentContainer().setRecord(record);
	     }
	},
	/*generico para el text field del los comentarios*/	
	onCommentFieldChange:function(textfield,nval,oval,o){
		textfield.up('container').items.items[1].setDisabled(nval.replace(/ /g,'') == '');
	}
})