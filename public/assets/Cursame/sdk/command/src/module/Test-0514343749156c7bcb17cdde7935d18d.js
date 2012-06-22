/**
 * @class Command.module.Test
 * @author Jacky Nguyen <jacky@sencha.com>
 */
Ext.define("Command.module.Test",{extend:"Command.module.Abstract",description:"Unit testing using Jasmine",actions:{run:["Run Jasmine's unit tests",["path","p","The *absolute* path to the directory that contains all spec files","string",null,"/path/to/specs"],["verbose","v","Whether to print extra information per each test run","boolean",!1,"yes"],["color","c","Whether to use color coding for output","boolean",!0,"no"]]},run:function(a,b,c){require("jasmine-node").executeSpecsInFolder(a,Ext.emptyFn,b,c)}});