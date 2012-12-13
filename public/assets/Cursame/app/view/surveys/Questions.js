/**
 * @class Cursame.view.surveys.Questions
 * @extends Ext.Carousel
 * The carousel for the sueyveys questions
 */
Ext.define('Cursame.view.surveys.Questions', {
    extend: 'Ext.Carousel',
    xtype: 'questionscarousel',
    questionsStack:[],
    beforeInitialize: function() {
        var me = this;
        this.mask({
            xtype: 'loadmask',
            message: lang.loading
        });
        Ext.getStore('Questions').load({
            params: {
                id: me.initialConfig.surveyId
            },
            callback: me.loadQuestions,
            scope: this
        });
        this.callParent(arguments);
        this.addEvents('surveyreplied');
    },
    loadQuestions: function(argument) {
        var me = this,
            items = [];
        Ext.getStore('Questions').each(function(item, index, length) {
            me.questionsStack[index] = false;
            var question = {
                xtype: 'container',
                defaults: {
                    cls: 'question'
                },
                scrollable: {
                    direction: 'vertical',
                    directionLock: true
                },
                items: [{
                    xtype: 'container',
                    tpl: Ext.create('Ext.XTemplate', '<div class="course  fill-container ">', '<div class="properties" style = "padding:20px">', '<p font-size = "18px">{text}</p>', '</div>', '</div>'),
                    data: item.data
                }]
            };

            Ext.each(item.data.answers, function(obj) {
                question.items.push({
                    xtype: 'container',
                    layout: 'hbox',
                    items: [{
                        name: 'question_'+obj.question_id,
                        xtype: 'radiofield',
                        width: 60,
                        value: obj.question_id + '_' + obj.uuid+'_'+index
                    }, {
                        xtype: 'label',
                        itemId: 'myLabel',
                        data: obj,
                        flex: 1,
                        tpl: ['<div class="answer">{text}</div>']
                    }]
                });
            }, me);
            items.push(question);
        });
        items.push({
            xtype: 'container',
            defaults: {
                xtype: 'container'
            },
            layout: 'vbox',
            items: [{
                flex: 3
            }, {
                xtype: 'button',
                ui: 'accept',
                margin: '50em',
                labelCls: 'finish-survey-button',
                flex: 2,
                text: lang.endSurvey,
                scope: me,
                handler: me.sendSurveys
            }, {
                flex: 3
            }]
        });
        me.setItems(items);
        me.setActiveItem(0);
        me.unmask();
    },
    sendSurveys: function(argument) {
        var replies = {},
            me = this,
            survey_answers_attributes = [],
            i = 0, enviar = false;

        Ext.iterate(me.getValues(), function(key, value) {
            key = value.split('_');
            replies[i] = {
                question_id: key[0],
                answer_uuid: key[1]
            };
            me.questionsStack[key[2]]=true;
            i++;
        }, me);
        //checamos si alguna pregunta no esta contestada entonces activamos esa pregunta para que la contesten.
        Ext.each(me.questionsStack,function(item, index){
            if(!item){
                me.setActiveItem(index);
                enviar = false;
                return false;
            }
            enviar = true;
        },me);

        if(!enviar){//si no estan todas las preguntas contestadas no las enviamos al server
            return false;
        }

        me.mask({
            xtype: 'loadmask',
            message: lang.sendingSurvey
        });

        Cursame.ajax({
            url: 'api/survey_replies',
            scope: me,
            params: {
                survey_id: me.initialConfig.surveyId,
                survey_reply: Ext.encode({
                    survey_answers_attributes: replies
                })
            },
            success: function(response) {
                me.unmask();
                me.mask({
                    xtype: 'loadmask',
                    message: lang.surveySend
                });
                setTimeout(function(){
                    me.unmask();
                    me.fireEvent('surveyreplied',me);
                },1000);
            }
        });
    },
    /* @private
     * Returns all {@link Ext.field.Field field} instances inside this form
     * @param byName return only fields that match the given name, otherwise return all fields.
     * @return {Object/Array} All field instances, mapped by field name; or an array if byName is passed
     */
    getFields: function(byName) {
        var fields = {},
            itemName;

        var getFieldsFrom = function(item) {
                if(item.isField) {
                    itemName = item.getName();

                    if((byName && itemName == byName) || typeof byName == 'undefined') {
                        if(fields.hasOwnProperty(itemName)) {
                            if(!Ext.isArray(fields[itemName])) {
                                fields[itemName] = [fields[itemName]];
                            }

                            fields[itemName].push(item);
                        } else {
                            fields[itemName] = item;
                        }
                    }
                }
                if(item.isContainer) {
                    item.items.each(getFieldsFrom);
                }
            };
        this.getItems().each(getFieldsFrom);
        return(byName) ? (fields[byName] || []) : fields;
    },
    /**
     * Returns an object containing the value of each field in the form, keyed to the field's name.
     * For groups of checkbox fields with the same name, it will be arrays of values. For example:
     *
     *     {
     *         name: "Jacky Nguyen", // From a TextField
     *         favorites: [
     *             'pizza',
     *             'noodle',
     *             'cake'
     *         ]
     *     }
     *
     * @param {Boolean} enabled <tt>true</tt> to return only enabled fields
     * @return {Object} Object mapping field name to its value
     */
    getValues: function(enabled) {
        var fields = this.getFields(),
            values = {},
            isArray = Ext.isArray,
            field, value, addValue, bucket, name, ln, i;

        // Function which you give a field and a name, and it will add it into the values
        // object accordingly
        addValue = function(field, name) {
            if(field.isCheckbox) {
                value = field.getSubmitValue();
            } else {
                value = field.getValue();
            }


            if(!(enabled && field.getDisabled())) {
                // RadioField is a special case where the value returned is the fields valUE
                // ONLY if it is checked
                if(field.isRadio) {
                    if(field.isChecked()) {
                        values[name] = value;
                    }
                } else {
                    // Check if the value already exists
                    bucket = values[name];
                    if(bucket) {
                        // if it does and it isn't an array, we need to make it into an array
                        // so we can push more
                        if(!isArray(bucket)) {
                            bucket = values[name] = [bucket];
                        }

                        // Check if it is an array
                        if(isArray(bucket)) {
                            // Concat it into the other values
                            bucket = values[name] = bucket.concat(value);
                        } else {
                            // If it isn't an array, just pushed more values
                            bucket.push(value);
                        }
                    } else {
                        values[name] = value;
                    }
                }
            }
        };

        // Loop through each of the fields, and add the values for those fields.
        for(name in fields) {
            if(fields.hasOwnProperty(name)) {
                field = fields[name];

                if(isArray(field)) {
                    ln = field.length;
                    for(i = 0; i < ln; i++) {
                        addValue(field[i], name);
                    }
                } else {
                    addValue(field, name);
                }
            }
        }

        return values;
    }
});