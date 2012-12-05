/**
 * @class Cursame.model.Question
 * @extends Ext.data.model
 * model for questions
 * @manduks <iam@armando.mx>
 * Armando Gonzalez
 */
Ext.define('Cursame.model.Question', {
	extend: 'Ext.data.Model',

	config: {
		fields: [{
			name: "id",
			type: "int"
		}, {
			name: "survey_id",
			type: "int"
		}, {
			name: "text",
			type: "string"
		}, {
			name: "position",
			type: "int"
		}, {
			name: "value",
			type: "int"
		},{
			name: "answers"
		}],
		proxy: {
			type: 'jsonp',
			url: Cursame.Url + 'api/questions.json',
			reader: {
				type: 'json',
				rootProperty: 'questions'
			}
		}
	}
});
/*
	t.integer   "survey_id"
    t.string    "answer_uuid"
    t.string    "text"
    t.timestamp "created_at"
    t.timestamp "updated_at"
    t.integer   "value"
    t.integer   "position" */