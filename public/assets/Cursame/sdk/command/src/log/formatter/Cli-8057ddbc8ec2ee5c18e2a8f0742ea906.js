Ext.define("Command.log.formatter.Cli",{extend:"Ext.log.formatter.Default",styles:{bold:[1,22],italic:[3,23],underline:[4,24],inverse:[7,27],white:[37,39],grey:[90,39],black:[30,39],blue:[34,39],cyan:[36,39],green:[32,39],magenta:[35,39],red:[31,39],yellow:[33,39]},priorityStyle:{verbose:["grey","bold"],info:["green","bold"],deprecate:["yellow","bold"],warn:["magenta","bold"],error:["red","bold"]},format:function(a){var b=a.priorityName,c=this.priorityStyle[b];return require("util").format("%s %s",this.style("["+b.toUpperCase()+"]",c),a.message)},style:function(a,b){var c,d,e,f;b=Ext.Array.from(b);for(d=0,e=b.length;d<e;d++)c=b[d],f=this.styles[c],a="["+f[0]+"m"+a+"["+f[1]+"m";return a}});