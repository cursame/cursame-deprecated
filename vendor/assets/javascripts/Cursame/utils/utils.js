Cursame={
	User:undefined,
	//Url:'http://mando.lvh.me:3000/api/',
	//Path:'http://mando.lvh.me:3000',
	Url:'/api/',
	Path:'',
	src:'Cursame/',
	ajax :function(obj){
		obj.url = Cursame.Url + obj.url;
		
		obj.params = Ext.applyIf({
			auth_token: Cursame.User.get('token')
		},obj.params);
		
        var o = Ext.applyIf({
                disableCaching:false,
                method :'GET',
				extraParams :{
					auth_token: Cursame.User.get('token')
				}
            },obj);
		Ext.data.JsonP.request(o);
    }
};