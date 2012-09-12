/**
 * @class Cursame.model.Notification
 * @extends Ext.data.Model
 * The Notification model is the model used for notifications. We're using a custom Proxy for
 * this application to enable us to consume Cursame's JSON api. See lib/CursameProxy.js to see how this is done
 */
Ext.define('Cursame.model.Notification', {
    extend:'Ext.data.Model',
    config:{
        fields:[
            {name:"id", type:"int"},
            {name:"text", type:"string", convert:function (value, record) {
				var text,data;
				if(value.text){
					text = value.text[0].toUpperCase() + value.text.slice(1);
					data = record.data;
                	data.user = value.user ? value.user.last_name + '' + value.user.first_name : '&nbsp;';
                	data.survey = value.survey ? value.survey.name : '';
                	data.asignment = value.asignment ? value.asignment.name : '';
                	data.course = value.course ? value.course.name : '';
                	data.text2 = value.text2 ? value.text2 : '';
                	data.state = value.notificator ? value.notificator.state : '';
                	data.course_id = value.course ? value.course.id : '';
                	data.courseObject = value.course ? value.course : '';
					data.courseOwner = value.course ? value.courseOwner : '';
					data.courseComments = value.course ? value.courseComments : '';
					data.courseMembers = value.course ? value.courseMembers : '';			
               		return [text,'<em class="active-font">',data.survey,'</em>', data.text2 ,'<em class="active-font">',data.course,'</em>'].join(' ');
				}
				return '';
            }},
            {name:"user_id", type:"string"},
            {name:"notificator_type", type:"string"},
            {name:"notificator_id", type:"string"},
            {name:"avatar", type:"string",mapping:'text',convert:function(value,record){				
				return value.user ? value.user.avatar_file.xsmall.url : value.image? value.image.xsmall.url:'resources/images/experto.png';				
			}},
            {name:"user", type:"string"},
            {name:"survey", type:"string"},
            {name:"asignment", type:"string"},
            {name:"course", type:"string"},
            {name:"text2", type:"string"},
            {name:"kind", type:"string"},
            {name:"state", type:"string"},
            {name:"course_id", type:"int"},
            {name:"courseObject"},
			{name:"courseOwner"},
			{name:"courseComments"},
			{name:"courseMembers"},
			{name:'btn', type:'boolean',convert:function(value,record){
				if(record.get('kind') === 'student_course_enrollment' && record.get('state') === 'pending'){ //si hay que mostrar los botones
					return false;
				}
				return true;
			}},
            {name:"created", type:"date", mapping:'created_at', convert:function(date,rec){
                    try {
                        var now = Math.ceil(Number(new Date()) / 1000),
                            dateTime = Math.ceil(Number(new Date(date)) / 1000),
                            diff = now - dateTime,
                            str;

                        if (diff < 60) {
                            return String(diff) + ' s';
                        } else if (diff < 3600) {
                            str = String(Math.ceil(diff / (60)));
                            return str + (str == "1" ? ' m' : ' m');
                        } else if (diff < 86400) {
                            str = String(Math.ceil(diff / (3600)));
                            return str + (str == "1" ? ' h' : ' h');
                        } else if (diff < 60 * 60 * 24 * 365) {
                            str = String(Math.ceil(diff / (60 * 60 * 24)));
                            return str + (str == "1" ? ' d' : ' d');
                        } else {
                            return Ext.Date.format(new Date(date), 'jS M \'y');
                        }
                    } catch (e) {
                        return '';
                    }                
			}}
        ],

        proxy:{
			type:'jsonp',
			url:Cursame.Url+'api/notifications.json',
            reader: {
                type: 'json',
                rootProperty: 'notifications'
            }
       }
   }
});



