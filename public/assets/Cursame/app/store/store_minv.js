Ext.define("Cursame.store.Assignments",{extend:"Core.data.Store",requires:["Cursame.model.Assignment"],config:{model:"Cursame.model.Assignment"}});Ext.define("Cursame.store.Comments",{extend:"Core.data.Store",requires:["Cursame.model.Comment"],config:{model:"Cursame.model.Comment"}});Ext.define("Cursame.store.CommentsComments",{extend:"Cursame.store.Comments"});Ext.define("Cursame.store.Courses",{extend:"Core.data.Store",requires:["Cursame.model.Course"],config:{model:"Cursame.model.Course"}});Ext.define("Cursame.store.Discussions",{extend:"Core.data.Store",requires:["Cursame.model.Discussion"],config:{model:"Cursame.model.Discussion"}});Ext.define("Cursame.store.Notifications",{extend:"Core.data.Store",requires:["Cursame.model.Notification"],config:{model:"Cursame.model.Notification",sorters:[{property:"created",direction:"DESC"}]}});Ext.define("Cursame.store.Surveys",{extend:"Core.data.Store",requires:["Cursame.model.Survey"],config:{model:"Cursame.model.Survey"}});Ext.define("Cursame.store.Users",{extend:"Core.data.Store",requires:["Cursame.model.User"],config:{model:"Cursame.model.User",grouper:{groupFn:function(a){return a.get("first_name")[0]}},sorters:"first_name"}});