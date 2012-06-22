Ext.define("Command.module.generate.App",{extend:"Command.module.generate.Generator",description:"Automates the generation of a new project",getUniqueId:function(){return require("node-uuid").v1()},execute:function(a){var b=require("path"),c=this.cli.getModule("fs"),d=process.cwd(),e=b.join(d,"version.txt"),f=new Ext.Version(require("fs").readFileSync(e,"utf8").trim()),g=b.resolve(a.path);this.mkdir(g,b.join(g,"app"),b.join(g,"app","model"),b.join(g,"app","view"),b.join(g,"app","controller"),b.join(g,"app","store"),b.join(g,"app","profile"),b.join(g,"sdk"),b.join(g,"sdk","command"),b.join(g,"sdk","src"),b.join(g,"sdk","resources"),b.join(g,"resources"),b.join(g,"resources","css"),b.join(g,"resources","images"),b.join(g,"resources","icons"),b.join(g,"resources","sass")),this.template(".senchasdk",b.join(g,".senchasdk")),this.template("index.html",b.join(g,"index.html")),this.template("app.js",b.join(g,"app.js")),this.template("packager.json",b.join(g,"packager.json")),this.template("app.json",b.join(g,"app.json"),{name:a.name,sdkShortVersion:f.getShortVersion(),sdkVersion:f.toString(),library:a.library,uniqueId:this.getUniqueId()}),this.template("app/view/Main.js",b.join(g,"app","view","Main.js")),this.directory(b.join(d,"src"),b.join(g,"sdk","src")),this.directory(b.join(d,"resources"),b.join(g,"sdk","resources")),this.directory(b.join(d,"command","src","module","generate","App","resources","icons"),b.join(g,"resources","icons")),this.directory(b.join(d,"command","src","module","generate","App","resources","loading"),b.join(g,"resources","loading")),this.directory(b.join(d,"command"),b.join(g,"sdk","command")),this.file(b.join(d,"microloader/development.js"),b.join(g,"sdk","microloader/development.js")),this.file(b.join(d,"microloader/testing.js"),b.join(g,"sdk","microloader/testing.js")),this.file(b.join(d,"microloader/production.js"),b.join(g,"sdk","microloader/production.js")),this.file(b.join(d,"version.txt"),b.join(g,"sdk","version.txt")),this.file(b.join(d,"sencha-touch-debug.js"),b.join(g,"sdk","sencha-touch.js")),this.file(b.join(d,"sencha-touch-all-debug.js"),b.join(g,"sdk","sencha-touch-all.js")),this.template("resources/sass/app.scss",b.join(g,"resources","sass","app.scss")),this.template("resources/sass/config.rb",b.join(g,"resources","sass","config.rb")),this.file(b.join(d,"resources/css-debug/sencha-touch.css"),b.join(g,"resources","css","app.css"))}});