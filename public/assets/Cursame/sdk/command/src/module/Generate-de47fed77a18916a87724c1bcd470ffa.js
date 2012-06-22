Ext.define("Command.module.Generate",{extend:"Command.module.Abstract",description:"Automates the generation of projects and files",actions:{app:["Generate a new project with the recommended structure",["name","n","The namespace of the application to create. This will be used as the prefix for all your classes","string",null,"MyApp"],["path","p","The directory path to generate this application to.","string",null,"/path/to/myapp"],["library","l","The library's build to develop your application with, either 'core' or 'all'. Defaults to 'core'.\n                          + Use 'all' if your application make use of almost every class available in the whole framework\n                          + Use 'core' if your application only make use of a portion of the framework. \n                            When you deploy the application, it only includes exactly what it needs.","string","core","all"]],model:["Generate a Model for an existing project",["name","n","The name of the Model to create","string",null,"User"],["fields","f","The set of fields to add to the Model","array",null,"id:int,name,email"]],controller:["Generate a Controller for an existing project",["name","n","The name of the Controller to create","string",null,"User"]],profile:["Generate a Profile for an existing project",["name","n","The name of the Profile to create","string",null,"Phone"]]},constructor:function(){var a=this.actions,b;for(b in a)this[b]=function(a){return function(){var b=this.actions[a].slice(1),c=b.length,d=[],e,f;for(f=0;f<c;f++)e=b[f][0],d[e]=arguments[f];Ext.create("Command.module.generate."+Ext.String.capitalize(a),d,this.cli)}}(b);this.callParent(arguments)}});