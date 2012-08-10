Ext.define('Cursame.controller.Main', {
    extend: 'Ext.app.Controller',

    config: {
        refs: {
            main: {
                selector: 'mainview'
            },
            notificationsList: 'notificationslist',
            notificationNavigationView: 'notificationnavigationview',
            courseContainer: 'coursecontainer',
            commentContainer: 'commentcontainer',
            courseWall: 'coursewall',
            commentWall: 'commentwall',
            commentWallButton: 'commentwall toolbar button',
            commentWallTextfield: 'commentwall toolbar textfield',
            courseWallButton: 'coursewall toolbar button',
            courseWallTextfield: 'coursewall toolbar textfield',
            courseNavigationView: 'coursenavigationview',
            courseList: 'coursenavigationview courselist',
            courseMenu: 'coursemenu',
            tabPanel: 'tabpanel',
            surveyWall: 'surveywall',
            assignmentWall: 'assignmentwall',
            assignmentContainer: 'assignmentcontainer',
            assignmentWallTextfield: 'assignmentwall toolbar textfield',
            discussionWall: 'discussionwall',
            discussionContainer: 'discussioncontainer',
            discussionWallTextfield: 'discussionwall toolbar textfield',
            userWall: 'usernavigationview userwall',
            userContainer: 'usercontainer',
            userNavigationView: 'usernavigationview',
            userWallTextfield: 'usernavigationview userwall toolbar textfield'
        },
        control: {
            'notificationslist notificationlistitem button': {
                tap: 'onNotificationButtonTap'
            },
            notificationslist: {
                itemtap: 'onNotificationTap'
            },
            coursewall: {
                itemtap: 'onCourseWallTap'
            },
            'commentwall commentbar button': {
                tap: 'onCommentWallPost'
            },
            'coursewall commentbar button': {
                tap: 'onCourseWallPost'
            },
            'commentwall commentbar textfield': {
                change: 'onCommentWallTextfieldChange'
            },
            'coursewall commentbar textfield': {
                change: 'onCourseWallTextfieldChange'
            },
            'coursenavigationview': {
                activate: 'onCourseListPaint'
            },
            'coursenavigationview courselist': {
                itemtap: 'onCourseTap'
            },
            'coursenavigationview coursemenu button': {
                tap: 'onCourseMenuTap'
            },
            'tabpanel': {
                activeitemchange: 'onTabPanelChange'
            },
            /*generic behavior for comments button*/'commentbar textfield': {
                change: 'onCommentFieldChange'
            },
            /*members*/'coursenavigationview userslist': {
                itemtap: 'onUsersListTap'
            },
            /*assignments*/'coursenavigationview assignmentslist': {
                itemtap: 'onAssignmentsListTap'
            },
            'notificationnavigationview assignmentslist': {
                itemtap: 'onAssignmentsListTap2'
            },
            'assignmentwall commentbar button': {
                tap: 'onAssignmentWallPost'
            },
            'assignmentwall': {
                itemtap: 'onAssignmentWallTap'
            },
            /*surveys*/'coursenavigationview surveyslist': {
                itemtap: 'onSurveysListTap'
            },
            'notificationnavigationview surveyslist': {
                itemtap: 'onSurveysListTap2'
            },
            //'coursenavigationview surveywall': {},
            /*discussions*/'coursenavigationview discussionslist': {
                itemtap: 'onDiscussionsListTap'
            },
            'notificationnavigationview discussionslist': {
                itemtap: 'onDiscussionsListTap2'
            },
            'discussionwall commentbar button': {
                tap: 'onDiscussionWallPost'
            },
            'discussionwall': {
                itemtap: 'onDiscussionWallTap'
            },
            /*user*/'usernavigationview userwall commentbar button': {
                tap: 'onUserWallPost'
            },
            'usernavigationview userwall': {
                itemtap: 'onUserWallTap'
            },
			/*comments*/
			'commentwall':{
				itemtap: 'onCommentWallTap'
			}
        }
    },
    launch: function () {},
    onLogin: function (form) {
        var store = Ext.getStore('Notifications');
        store.load();
    },
    onNotificationButtonTap: function (button, e) {
        var item = button.getParent(),
            record = item.getRecord();

        this.maskComponent(this.getNotificationsList());

        Cursame.ajax({
            url: 'api/course_requests',
            scope: this,
            params: {
                id: record.data.notificator_id,
                accept: button.config.accept
            },
            success: function (response) {
                Ext.getStore('Notifications').load({
                    callback: this.onNotificationsStoreLoad,
                    scope: this
                });
            }
        });
    },
    onNotificationsStoreLoad: function () {
        this.getNotificationsList().setMasked(false);
    },
    onNotificationTap: function (dataview, index, target, record, e) {
        var type = record.get('kind');
        if (type === 'student_assignment_delivery' || type === 'teacher_survey_replied') { // si trata de una entrega de la tarea
            Ext.Msg.alert('Cursame', 'Para utilizar esta función por favor utiliza Cúrsame desde una computadora o tablet.', Ext.emptyFn);
            return;
        }

        if (type === 'user_comment_on_course' || type === 'student_course_accepted' || type === 'student_course_enrollment') {
            this.getNotificationNavigationView().push({
                xtype: 'coursewall',
                title: record.data.courseObject.name
            });
            this.loadStore(Ext.getStore('Comments'), {
                id: record.get('course_id'),
                type: 'Course'
            }, undefined);
            var courseObject = record.get('courseObject'),
                courseOwner = record.get('courseOwner');
            var course = Ext.create('Cursame.model.Course', {
                id: courseObject.id,
                name: courseObject.name,
                description: courseObject.description,
                image: courseObject.logo_file,
                'public': courseObject.public,
                start_date: courseObject.start_date,
                finish_date: courseObject.finish_date,
                owner: courseOwner.first_name + ' ' + courseOwner.last_name,
                members: record.get('courseMembers')
            });
            this.getCourseContainer().setRecord(course);
            return;
        }
        if (type === 'user_comment_on_discussion' || type === 'course_discussion_added') {
            this.getNotificationNavigationView().push({
                xtype: 'discussionslist',
                title: lang.discussions
            });
            this.loadStore(Ext.getStore('Discussions'), {
                id: record.data.courseObject.id
            }, undefined);
            return;
        }
        if (type === 'student_assignment_added' || type === 'student_assignment_updated') {
            this.getNotificationNavigationView().push({
                xtype: 'assignmentslist',
                title: lang.assignments
            });
            this.loadStore(Ext.getStore('Assignments'), {
                id: record.data.courseObject.id
            }, undefined);
        }
        if (type === 'student_survey_added' || type === 'student_survey_updated') {
            this.getNotificationNavigationView().push({
                xtype: 'surveyslist',
                title: lang.surveys
            });
            this.loadStore(Ext.getStore('Surveys'), {
                id: record.data.courseObject.id
            }, undefined);
        }
        if (type === 'user_comment_on_comment') {
            this.getNotificationNavigationView().push({
                xtype: 'commentwall',
                title: lang.comments
            });
            this.loadStore(Ext.getStore('CommentsComments'), {
                id: record.get('notificator_id'),
                type: 'Comment'
            }, undefined);
            var r = record.raw.text.notificator,
                user = record.raw.text.user;
            r.numcommnets = 888;
            r.user_id = user.id;
            r.userfirstname = user.first_name;
            r.userlasttname = user.last_name;
            r.userimage = user.avatar_file.small.url;

            var commnent = Ext.create('Cursame.model.Comment', r);
            this.getCommentContainer().setRecord(commnent);
        }
    },
    maskComponent: function (cmp) {
        cmp.setMasked({
            xtype: 'loadmask',
            message: lang.loading
        });
    },
    onCourseWallTap: function (dataview, index, target, record, e, opt) {
		var like = 0,target;
        if (e.getTarget('div.info')) {
            if (this.getNotificationNavigationView().getItems().length === 3) { //si se tiene que agregar a notificaciones el commentwall
                this.getNotificationNavigationView().push({
                    xtype: 'commentwall',
                    title: lang.comments
                });
            } else { //si se tiene que agregar a curso
                this.getCourseNavigationView().push({
                    xtype: 'commentwall',
                    title: lang.comments
                });
            }
            this.loadStore(Ext.getStore('CommentsComments'), {
                id: record.get('id'),
                type: 'Comment'
            }, undefined);
            this.getCommentContainer().setRecord(record);
        }
		else if (e.getTarget('div.action')){
			target = e.getTarget('div.action');
			if(target.innerHTML === lang.like){
				like = 1;
				record.data.like = lang.notLike;
			}
			this.saveLike(record.get('id'), like, target);
		}
    },
    onUserWallTap: function (dataview, index, target, record, e, opt) {
		var like = 0,target;
        if (e.getTarget('div.info')) {
            this.getUserNavigationView().push({
                xtype: 'commentwall',
                title: lang.comments
            });
            this.loadStore(Ext.getStore('CommentsComments'), {
                id: record.get('id'),
                type: 'Comment'
            }, undefined);
            this.getCommentContainer().setRecord(record);
        }
		else if (e.getTarget('div.action')){
			target = e.getTarget('div.action');
			if(target.innerHTML === lang.like){
				like = 1;
				record.data.like = lang.notLike;
			}
			this.saveLike(record.get('id'), like, target);
		}
    },
	onCommentWallTap:function(dataview, index, target, record, e, opt){
		var like = 0,target;
		if (e.getTarget('div.action')){
			target = e.getTarget('div.action');
			if(target.innerHTML === lang.like){
				like = 1;
				record.data.like = lang.notLike;
			}
			this.saveLike(record.get('id'), like, target);
		}
	},
	saveLike: function (type, like,target) {
		var text = lang.like;
		if(like){
			text = lang.notLike;
		}		
        Cursame.ajax({
            url: 'api/create_like',
            scope: this,
            params: {
                like: like,
				type: type
            },
            success: function (response) {
                target.innerHTML = text;
            }
        });
    },
    loadStore: function (store, params, callback) {
        store.load({
            callback: callback,
            params: params,
            scope: this
        });
    },
    loadCommentsStore: function (store) {

    },
    onCommentWallTextfieldChange: function (textfield, nval, oval, o) {
        this.getCommentWallButton().setDisabled(nval.replace(/ /g, '') == '');
    },
    onCourseWallTextfieldChange: function (textfield, nval, oval, o) {
        this.getCourseWallButton().setDisabled(nval.replace(/ /g, '') == '');
    },
    onCommentWallPost: function (btn) {
        var record = this.getCommentContainer().getRecord();
        this.saveComment('Comment', this.getCommentWallTextfield(), btn, record.get('id'), Ext.getStore('CommentsComments'));
    },
    onCourseWallPost: function (btn) {
        var record = this.getCourseContainer().getRecord();
        this.saveComment('Course', this.getCourseWallTextfield(), btn, record.get('id'), Ext.getStore('Comments'));
    },
    onAssignmentWallPost: function (btn) {
        var record = this.getAssignmentContainer().getRecord();
        this.saveComment('Assignment', this.getAssignmentWallTextfield(), btn, record.get('id'), Ext.getStore('Comments'));
    },
    onDiscussionWallPost: function (btn) {
        var record = this.getDiscussionContainer().getRecord();
        this.saveComment('Discussion', this.getDiscussionWallTextfield(), btn, record.get('id'), Ext.getStore('Comments'));
    },
    onUserWallPost: function (btn) {
        var record = this.getUserWall().items.items[0].getRecord();
        this.saveComment('User', this.getUserWallTextfield(), btn, record.get('id'), Ext.getStore('Comments'));
    },
    saveComment: function (type, textfield, btn, comentableId, store) {
        btn.disable();
        Cursame.ajax({
            url: 'api/create_comment',
            scope: this,
            params: {
                commentable_type: type,
                commentable_id: comentableId,
                text: textfield.getValue()
            },
            success: function (response) {
                this.loadStore(store, {
                    id: comentableId,
                    type: type
                }, function () {
                    textfield.reset();
                });
            }
        });
    },
    onCourseListPaint: function (view) {
        Ext.getStore('Courses').load();
    },
    onCourseTap: function (dataview, index, target, record, e, opt) {
        this.getCourseNavigationView().push({
            xtype: 'coursemenu',
            title: record.get('name')
        });
        this.getCourseMenu().items.items[0].setRecord(record);
    },
    onCourseMenuTap: function (btn) {
        var courseContainer = btn.up('container').up('container'),
            courseItems = courseContainer.items.items,
            courseRecord = courseItems[0].getRecord();
        btn.disable();
        switch (btn.config.action) {
        case 'wall':
            this.getCourseNavigationView().push({
                xtype: 'coursewall',
                title: courseRecord.get('name')
            });
            this.loadStore(Ext.getStore('Comments'), {
                id: courseRecord.get('id'),
                type: 'Course'
            }, undefined);
            this.getCourseContainer().setRecord(courseRecord);
            break;
        case 'members':
            this.getCourseNavigationView().push({
                xtype: 'userslist',
                title: lang.members
            });
            this.loadStore(Ext.getStore('Users'), {
                id: courseRecord.get('id'),
                type: 'Course'
            }, undefined);
            break;
        case 'assignments':
            this.getCourseNavigationView().push({
                xtype: 'assignmentslist',
                title: lang.assignments
            });
            this.loadStore(Ext.getStore('Assignments'), {
                id: courseRecord.get('id')
            }, undefined);
            break;
        case 'surveys':
            this.getCourseNavigationView().push({
                xtype: 'surveyslist',
                title: lang.surveys
            });
            this.loadStore(Ext.getStore('Surveys'), {
                id: courseRecord.get('id')
            }, undefined);
            break;
        case 'discussions':
            this.getCourseNavigationView().push({
                xtype: 'discussionslist',
                title: lang.discussions
            });
            this.loadStore(Ext.getStore('Discussions'), {
                id: courseRecord.get('id')
            }, undefined);
            break;
        }
        btn.enable();
    },
    /*solo para el telefono*/
    onTabPanelChange: function (tabpanel, value, oldValue, opts) {
        var cuantos = oldValue.getItems().length;
        oldValue.pop(cuantos - 1);
        if (value.config.type === 'user') {
            this.loadStore(Ext.getStore('Comments'), {
                id: Cursame.User.get('id'),
                type: 'User'
            }, undefined);
            this.getUserWall().items.items[0].setRecord(Cursame.User);
        }
    },
    /*members*/
    onUsersListTap: function () {
        //alert(888);
    },
    /*assignments*/
    onAssignmentsListTap: function (dataview, index, target, record, e, opt) {
        this.getCourseNavigationView().push({
            xtype: 'assignmentwall',
            title: record.get('name')
        });
        this.loadStore(Ext.getStore('Comments'), {
            id: record.get('id'),
            type: 'Assignment'
        }, undefined);
        this.getAssignmentWall().items.items[0].setRecord(record);
    },
    onAssignmentsListTap2: function (dataview, index, target, record, e, opt) {
        this.getNotificationNavigationView().push({
            xtype: 'assignmentwall',
            title: record.get('name')
        });
        this.loadStore(Ext.getStore('Comments'), {
            id: record.get('id'),
            type: 'Assignment'
        }, undefined);
        this.getAssignmentWall().items.items[0].setRecord(record);
    },
    onAssignmentWallTap: function (dataview, index, target, record, e, opt) {
        if (e.getTarget('div.minibar')) {
            this.getCourseNavigationView().push({
                xtype: 'commentwall',
                title: lang.comments
            });
            this.loadStore(Ext.getStore('CommentsComments'), {
                id: record.get('id'),
                type: 'Comment'
            }, undefined);
            this.getCommentContainer().setRecord(record);
        }
    },
    /*surveys*/
    onSurveysListTap: function (dataview, index, target, record, e, opt) {
        this.getCourseNavigationView().push({
            xtype: 'surveywall',
            title: record.get('name')
        });
        this.loadStore(Ext.getStore('Comments'), {
            id: record.get('id'),
            type: 'Survey'
        }, undefined);
        this.getSurveyWall().items.items[0].setRecord(record);
    },
    onSurveysListTap2: function (dataview, index, target, record, e, opt) {
        this.getNotificationNavigationView().push({
            xtype: 'surveywall',
            title: record.get('name')
        });
        this.loadStore(Ext.getStore('Comments'), {
            id: record.get('id'),
            type: 'Survey'
        }, undefined);
        this.getSurveyWall().items.items[0].setRecord(record);
    },
    /*discussions*/
    onDiscussionsListTap: function (dataview, index, target, record, e, opt) {
        this.getCourseNavigationView().push({
            xtype: 'discussionwall',
            title: record.get('name')
        });
        this.loadStore(Ext.getStore('Comments'), {
            id: record.get('id'),
            type: 'Discussion'
        }, undefined);
        this.getDiscussionWall().items.items[0].setRecord(record);
    },
    onDiscussionsListTap2: function (dataview, index, target, record, e, opt) {
        this.getNotificationNavigationView().push({
            xtype: 'discussionwall',
            title: record.get('name')
        });
        this.loadStore(Ext.getStore('Comments'), {
            id: record.get('id'),
            type: 'Discussion'
        }, undefined);
        this.getDiscussionWall().items.items[0].setRecord(record);
    },
    onDiscussionWallTap: function (dataview, index, target, record, e, opt) {
        if (e.getTarget('div.minibar')) {
            this.getCourseNavigationView().push({
                xtype: 'commentwall',
                title: lang.comments
            });
            this.loadStore(Ext.getStore('CommentsComments'), {
                id: record.get('id'),
                type: 'Comment'
            }, undefined);
            this.getCommentContainer().setRecord(record);
        }
    },
    /*generico para el text field del los comentarios*/
    onCommentFieldChange: function (textfield, nval, oval, o) {
        textfield.up('container').items.items[1].setDisabled(nval.replace(/ /g, '') == '');
    }
})	