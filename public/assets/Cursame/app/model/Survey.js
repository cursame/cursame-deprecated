/**
 * @class Cursame.model.Survey
 * @extends Ext.data.model
 * model for Surveys
 */
Ext.define('Cursame.model.Survey', {
    extend: 'Ext.data.Model',
    
    config:{
		fields:[
	    	{name:"id", type:"int"},
			{name:"course_id", type:"int"},
	        {name:"name", type:"string"},
	        {name:"description", type:"string"},
	        {name:"value", type:"int"},			
			{name:"period", type:"int"},
			{
				name:"due_to", type:'date', dateFormat: 'c', convert:function(value,record){
				return Ext.Date.format(new Date(value), 'd-m-Y, g:i a');
				}
			},
			{name:"start_at"},
			{name:"state"},
	     ],
	     proxy:{
	     	type:'jsonp',
			url:Cursame.Url+'api/surveys.json',
            reader: {
                type: 'json',
                rootProperty: 'surveys'
            }
	     }
	}
});

/*t.integer  "course_id"
t.string   "name"
t.text     "description"
t.integer  "value"
t.integer  "period"
t.datetime "due_to"
t.datetime "created_at"
t.datetime "updated_at"
t.string   "state"
t.datetime "start_at""*/