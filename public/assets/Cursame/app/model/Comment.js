/**
 * @class Cursame.model.Comment
 * @extends Ext.data.Model
 * The Comment model is the model used for comments.
 */
Ext.define('Cursame.model.Comment', {
    extend:'Ext.data.Model',
    config:{
        fields:[
            {name:"id", type:"int"},
            {name:"commentable_id", type:"int"},
            {name:"commentable_type", type:"string"},
            {name:"created_at", type:"date"},
            {name:"text", type:"string"},
            {name:"user_id", type:"int"},
            {name:"userfirstname", type:"string",mapping:'user.first_name'},
            {name:"userlasttname", type:"string",mapping:'user.last_name'},
            {name:"userimage", type:"string",mapping:'user.avatar_file.small.url'},
            {name:"numcommnets", type:"int",mapping:'comments',convert:function (value, record) {
                return  value.length;
            }}
        ],

        proxy:{
            type:'jsonp',
			url:Cursame.Url+'api/comments.json',
            reader: {
                type: 'json',
                rootProperty: 'comments'
            }
        }
    }
});



