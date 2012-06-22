/**
 * WYSIWYG - jQuery plugin 0.97
 * (0.97.2 - From infinity)
 *
 * Copyright (c) 2008-2009 Juan M Martinez, 2010-2011 Akzhan Abdulin and all contributors
 * https://github.com/akzhan/jwysiwyg
 *
 * Dual licensed under the MIT and GPL licenses:
 *   http://www.opensource.org/licenses/mit-license.php
 *   http://www.gnu.org/licenses/gpl.html
 *
 */
/*jslint browser: true, forin: true */
(function(a){function d(){this.controls={bold:{groupIndex:0,visible:!0,tags:["b","strong"],css:{fontWeight:"bold"},tooltip:"Bold",hotkey:{ctrl:1,key:66}},copy:{groupIndex:8,visible:!1,tooltip:"Copy"},createLink:{groupIndex:6,visible:!0,exec:function(){var c=this;a.wysiwyg.controls&&a.wysiwyg.controls.link?a.wysiwyg.controls.link.init(this):a.wysiwyg.autoload?a.wysiwyg.autoload.control("wysiwyg.link.js",function(){c.controls.createLink.exec.apply(c)}):b.error("$.wysiwyg.controls.link not defined. You need to include wysiwyg.link.js file")},tags:["a"],tooltip:"Create link"},cut:{groupIndex:8,visible:!1,tooltip:"Cut"},decreaseFontSize:{groupIndex:9,visible:!1,tags:["small"],tooltip:"Decrease font size",exec:function(){this.decreaseFontSize()}},h1:{groupIndex:7,visible:!0,className:"h1",command:a.browser.msie||a.browser.safari?"FormatBlock":"heading",arguments:a.browser.msie||a.browser.safari?"<h1>":"h1",tags:["h1"],tooltip:"Header 1"},h2:{groupIndex:7,visible:!0,className:"h2",command:a.browser.msie||a.browser.safari?"FormatBlock":"heading",arguments:a.browser.msie||a.browser.safari?"<h2>":"h2",tags:["h2"],tooltip:"Header 2"},h3:{groupIndex:7,visible:!0,className:"h3",command:a.browser.msie||a.browser.safari?"FormatBlock":"heading",arguments:a.browser.msie||a.browser.safari?"<h3>":"h3",tags:["h3"],tooltip:"Header 3"},highlight:{tooltip:"Highlight",className:"highlight",groupIndex:1,visible:!1,css:{backgroundColor:"rgb(255, 255, 102)"},exec:function(){var b,c,d,e;a.browser.msie||a.browser.safari?b="backcolor":b="hilitecolor";if(a.browser.msie)c=this.getInternalRange().parentElement();else{d=this.getInternalSelection(),c=d.extentNode||d.focusNode;while(c.style===undefined){c=c.parentNode;if(c.tagName&&c.tagName.toLowerCase()==="body")return}}c.style.backgroundColor==="rgb(255, 255, 102)"||c.style.backgroundColor==="#ffff66"?e="#ffffff":e="#ffff66",this.editorDoc.execCommand(b,!1,e)}},html:{groupIndex:10,visible:!1,exec:function(){var b;this.options.resizeOptions&&a.fn.resizable&&(b=this.element.height()),this.viewHTML?(this.setContent(this.original.value),a(this.original).hide(),this.editor.show(),this.options.resizeOptions&&a.fn.resizable&&(b===this.element.height()&&this.element.height(b+this.editor.height()),this.element.resizable(a.extend(!0,{alsoResize:this.editor},this.options.resizeOptions))),this.ui.toolbar.find("li").each(function(){var b=a(this);b.hasClass("html")?b.removeClass("active"):b.removeClass("disabled")})):(this.saveContent(),a(this.original).css({width:this.element.outerWidth()-6,height:this.element.height()-this.ui.toolbar.height()-6,resize:"none"}).show(),this.editor.hide(),this.options.resizeOptions&&a.fn.resizable&&(b===this.element.height()&&this.element.height(this.ui.toolbar.height()),this.element.resizable("destroy")),this.ui.toolbar.find("li").each(function(){var b=a(this);b.hasClass("html")?b.addClass("active"):!1===b.hasClass("fullscreen")&&b.removeClass("active").addClass("disabled")})),this.viewHTML=!this.viewHTML},tooltip:"View source code"},increaseFontSize:{groupIndex:9,visible:!1,tags:["big"],tooltip:"Increase font size",exec:function(){this.increaseFontSize()}},indent:{groupIndex:2,visible:!0,tooltip:"Indent"},insertHorizontalRule:{groupIndex:6,visible:!0,tags:["hr"],tooltip:"Insert Horizontal Rule"},insertImage:{groupIndex:6,visible:!0,exec:function(){var c=this;a.wysiwyg.controls&&a.wysiwyg.controls.image?a.wysiwyg.controls.image.init(this):a.wysiwyg.autoload?a.wysiwyg.autoload.control("wysiwyg.image.js",function(){c.controls.insertImage.exec.apply(c)}):b.error("$.wysiwyg.controls.image not defined. You need to include wysiwyg.image.js file")},tags:["img"],tooltip:"Insert image"},insertOrderedList:{groupIndex:5,visible:!0,tags:["ol"],tooltip:"Insert Ordered List"},insertTable:{groupIndex:6,visible:!1,exec:function(){var c=this;a.wysiwyg.controls&&a.wysiwyg.controls.table?a.wysiwyg.controls.table(this):a.wysiwyg.autoload?a.wysiwyg.autoload.control("wysiwyg.table.js",function(){c.controls.insertTable.exec.apply(c)}):b.error("$.wysiwyg.controls.table not defined. You need to include wysiwyg.table.js file")},tags:["table"],tooltip:"Insert table"},insertUnorderedList:{groupIndex:5,visible:!0,tags:["ul"],tooltip:"Insert Unordered List"},italic:{groupIndex:0,visible:!0,tags:["i","em"],css:{fontStyle:"italic"},tooltip:"Italic",hotkey:{ctrl:1,key:73}},justifyCenter:{groupIndex:1,visible:!0,tags:["center"],css:{textAlign:"center"},tooltip:"Justify Center"},justifyFull:{groupIndex:1,visible:!0,css:{textAlign:"justify"},tooltip:"Justify Full"},justifyLeft:{visible:!0,groupIndex:1,css:{textAlign:"left"},tooltip:"Justify Left"},justifyRight:{groupIndex:1,visible:!0,css:{textAlign:"right"},tooltip:"Justify Right"},ltr:{groupIndex:10,visible:!1,exec:function(){var b=this.dom.getElement("p");return b?(a(b).attr("dir","ltr"),!0):!1},tooltip:"Left to Right"},outdent:{groupIndex:2,visible:!0,tooltip:"Outdent"},paragraph:{groupIndex:7,visible:!1,className:"paragraph",command:"FormatBlock",arguments:a.browser.msie||a.browser.safari?"<p>":"p",tags:["p"],tooltip:"Paragraph"},paste:{groupIndex:8,visible:!1,tooltip:"Paste"},redo:{groupIndex:4,visible:!0,tooltip:"Redo"},removeFormat:{groupIndex:10,visible:!1,exec:function(){this.removeFormat()},tooltip:"Remove formatting"},rtl:{groupIndex:10,visible:!1,exec:function(){var b=this.dom.getElement("p");return b?(a(b).attr("dir","rtl"),!0):!1},tooltip:"Right to Left"},strikeThrough:{groupIndex:0,visible:!0,tags:["s","strike"],css:{textDecoration:"line-through"},tooltip:"Strike-through"},subscript:{groupIndex:3,visible:!0,tags:["sub"],tooltip:"Subscript"},superscript:{groupIndex:3,visible:!0,tags:["sup"],tooltip:"Superscript"},underline:{groupIndex:0,visible:!0,tags:["u"],css:{textDecoration:"underline"},tooltip:"Underline",hotkey:{ctrl:1,key:85}},undo:{groupIndex:4,visible:!0,tooltip:"Undo"},code:{visible:!1,groupIndex:6,tooltip:"Code snippet",exec:function(){var b=this.getInternalRange(),c=a(b.commonAncestorContainer),d=b.commonAncestorContainer.nodeName.toLowerCase();c.parent("code").length?c.unwrap():d!=="body"&&c.wrap("<code/>")}},cssWrap:{visible:!1,groupIndex:6,tooltip:"CSS Wrapper",exec:function(){a.wysiwyg.controls.cssWrap.init(this)}}},this.defaults={html:'<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd"><html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" style="margin:0"><head><meta http-equiv="Content-Type" content="text/html; charset=UTF-8"></head><body style="margin:10px;color:gray;">INITIAL_CONTENT</body></html>',debug:!1,controls:{},css:{},events:{},autoGrow:!1,autoSave:!0,brIE:!0,formHeight:270,formWidth:440,iFrameClass:null,initialContent:"<p>&nbsp;</p>",maxHeight:1e4,maxLength:0,messages:{nonSelection:"Select the text you wish to link"},toolbarHtml:'<ul role="menu" class="toolbar"></ul>',removeHeadings:!1,replaceDivWithP:!1,resizeOptions:!1,rmUnusedControls:!1,rmUnwantedBr:!0,tableFiller:"Lorem ipsum",initialMinHeight:null,controlImage:{forceRelativeUrls:!1},controlLink:{forceRelativeUrls:!1},plugins:{autoload:!1,i18n:!1,rmFormat:{rmMsWordMarkup:!1}},dialog:"default"},this.availableControlProperties=["arguments","callback","className","command","css","custom","exec","groupIndex","hotkey","icon","tags","tooltip","visible"],this.editor=null,this.editorDoc=null,this.element=null,this.options={},this.original=null,this.savedRange=null,this.timers=[],this.validKeyCodes=[8,9,13,16,17,18,19,20,27,33,34,35,36,37,38,39,40,45,46],this.isDestroyed=!1,this.dom={ie:{parent:null},w3c:{parent:null}},this.dom.parent=this,this.dom.ie.parent=this.dom,this.dom.w3c.parent=this.dom,this.ui={},this.ui.self=this,this.ui.toolbar=null,this.ui.initialHeight=null,this.dom.getAncestor=function(a,b){b=b.toLowerCase();while(a&&typeof a.tagName!="undefined"&&"body"!==a.tagName.toLowerCase()){if(b===a.tagName.toLowerCase())return a;a=a.parentNode}if(!a.tagName&&(a.previousSibling||a.nextSibling)){if(a.previousSibling&&a.previousSibling.tagName.toLowerCase()==b)return a.previousSibling;if(a.nextSibling&&a.nextSibling.tagName.toLowerCase()==b)return a.nextSibling}return null},this.dom.getElement=function(a){var b=this;return a=a.toLowerCase(),window.getSelection?b.w3c.getElement(a):b.ie.getElement(a)},this.dom.ie.getElement=function(a){var b=this.parent,c=b.parent.getInternalSelection(),d=c.createRange(),e;if("Control"===c.type){if(1!==d.length)return null;e=d.item(0)}else e=d.parentElement();return b.getAncestor(e,a)},this.dom.w3c.getElement=function(a){var b=this.parent,c=b.parent.getInternalRange(),d;if(!c)return null;d=c.commonAncestorContainer,3===d.nodeType&&(d=d.parentNode),d===c.startContainer&&(d=d.childNodes[c.startOffset]);if(!d.tagName&&(d.previousSibiling||d.nextSibling)){if(d.previousSibiling&&d.previousSibiling.tagName.toLowerCase()==a)return d.previousSibiling;if(d.nextSibling&&d.nextSibling.tagName.toLowerCase()==a)return d.nextSibling}return b.getAncestor(d,a)},this.ui.addHoverClass=function(){a(this).addClass("wysiwyg-button-hover")},this.ui.appendControls=function(){var b=this,c=this.self,d=c.parseControls(),e=!0,f=[],g={},h,i,j=function(a,c){c.groupIndex&&i!==c.groupIndex&&(i=c.groupIndex,e=!1);if(!c.visible)return;e||(b.appendItemSeparator(),e=!0),c.custom?b.appendItemCustom(a,c):b.appendItem(a,c)};a.each(d,function(a,b){var c="empty";undefined!==b.groupIndex&&(""===b.groupIndex?c="empty":c=b.groupIndex),undefined===g[c]&&(f.push(c),g[c]={}),g[c][a]=b}),f.sort(function(a,b){return"number"==typeof a&&typeof a==typeof b?a-b:(a=a.toString(),b=b.toString(),a>b?1:a===b?0:-1)}),0<f.length&&(i=f[0]);for(h=0;h<f.length;h+=1)a.each(g[f[h]],j)},this.ui.appendItem=function(b,c){var d=this.self,e=c.className||c.command||b||"empty",f=c.tooltip||c.command||b||"";return a('<li role="menuitem" unselectable="on">'+e+"</li>").addClass(e).attr("title",f).hover(this.addHoverClass,this.removeHoverClass).click(function(){return a(this).hasClass("disabled")?!1:(d.triggerControl.apply(d,[b,c]),this.blur(),d.ui.returnRange(),d.ui.focus(),!0)}).appendTo(d.ui.toolbar)},this.ui.appendItemCustom=function(b,c){var d=this.self,e=c.tooltip||c.command||b||"";return c.callback&&a(window).bind("trigger-"+b+".wysiwyg",c.callback),a('<li role="menuitem" unselectable="on" style="background: url(\''+c.icon+"') no-repeat;\"></li>").addClass("custom-command-"+b).addClass("wysiwyg-custom-command").addClass(b).attr("title",e).hover(this.addHoverClass,this.removeHoverClass).click(function(){return a(this).hasClass("disabled")?!1:(d.triggerControl.apply(d,[b,c]),this.blur(),d.ui.returnRange(),d.ui.focus(),d.triggerControlCallback(b),!0)}).appendTo(d.ui.toolbar)},this.ui.appendItemSeparator=function(){var b=this.self;return a('<li role="separator" class="separator"></li>').appendTo(b.ui.toolbar)},this.autoSaveFunction=function(){this.saveContent()},this.ui.checkTargets=function(b){var c=this.self;a.each(c.options.controls,function(d,e){var f=e.className||e.command||d||"empty",g,h,i,j,k=function(a,b){var d;"function"==typeof b?(d=b,d(j.css(a).toString().toLowerCase(),c)&&c.ui.toolbar.find("."+f).addClass("active")):j.css(a).toString().toLowerCase()===b&&c.ui.toolbar.find("."+f).addClass("active")};"fullscreen"!==f&&c.ui.toolbar.find("."+f).removeClass("active");if(e.tags||e.options&&e.options.tags){g=e.tags||e.options&&e.options.tags,h=b;while(h){if(h.nodeType!==1)break;a.inArray(h.tagName.toLowerCase(),g)!==-1&&c.ui.toolbar.find("."+f).addClass("active"),h=h.parentNode}}if(e.css||e.options&&e.options.css){i=e.css||e.options&&e.options.css,j=a(b);while(j){if(j[0].nodeType!==1)break;a.each(i,k),j=j.parent()}}})},this.ui.designMode=function(){var a=3,b=this.self,c;c=function(a){if("on"===b.editorDoc.designMode){b.timers.designMode&&window.clearTimeout(b.timers.designMode),b.innerDocument()!==b.editorDoc&&b.ui.initFrame();return}try{b.editorDoc.designMode="on"}catch(d){}a-=1,a>0&&(b.timers.designMode=window.setTimeout(function(){c(a)},100))},c(a)},this.destroy=function(){this.isDestroyed=!0;var b,c=this.element.closest("form");for(b=0;b<this.timers.length;b+=1)window.clearTimeout(this.timers[b]);return c.unbind(".wysiwyg"),this.element.remove(),a.removeData(this.original,"wysiwyg"),a(this.original).show(),this},this.getRangeText=function(){var a=this.getInternalRange();return a.toString?a=a.toString():a.text&&(a=a.text),a},this.execute=function(a,b){typeof b=="undefined"&&(b=null),this.editorDoc.execCommand(a,!1,b)},this.extendOptions=function(b){var c={};return"object"==typeof b.controls&&(c=b.controls,delete b.controls),b=a.extend(!0,{},this.defaults,b),b.controls=a.extend(!0,{},c,this.controls,c),b.rmUnusedControls&&a.each(b.controls,function(a){c[a]||delete b.controls[a]}),b},this.ui.focus=function(){var a=this.self;return a.editor.get(0).contentWindow.focus(),a},this.ui.returnRange=function(){var a=this.self,c;if(a.savedRange!==null){if(window.getSelection){c=window.getSelection(),c.rangeCount>0&&c.removeAllRanges();try{c.addRange(a.savedRange)}catch(d){b.error(d)}}else window.document.createRange?window.getSelection().addRange(a.savedRange):window.document.selection&&a.savedRange.select();a.savedRange=null}},this.increaseFontSize=function(){if(a.browser.mozilla||a.browser.opera)this.editorDoc.execCommand("increaseFontSize",!1,null);else if(a.browser.safari){var c=this.getInternalRange(),d=this.getInternalSelection(),e=this.editorDoc.createElement("big");if(!0===c.collapsed&&3===c.commonAncestorContainer.nodeType){var f=c.commonAncestorContainer.nodeValue.toString(),g=f.lastIndexOf(" ",c.startOffset)+1,h=-1===f.indexOf(" ",c.startOffset)?f:f.indexOf(" ",c.startOffset);c.setStart(c.commonAncestorContainer,g),c.setEnd(c.commonAncestorContainer,h),c.surroundContents(e),d.addRange(c)}else c.surroundContents(e),d.removeAllRanges(),d.addRange(c)}else b.error("Internet Explorer?")},this.decreaseFontSize=function(){if(a.browser.mozilla||a.browser.opera)this.editorDoc.execCommand("decreaseFontSize",!1,null);else if(a.browser.safari){var c=this.getInternalRange(),d=this.getInternalSelection(),e=this.editorDoc.createElement("small");if(!0===c.collapsed&&3===c.commonAncestorContainer.nodeType){var f=c.commonAncestorContainer.nodeValue.toString(),g=f.lastIndexOf(" ",c.startOffset)+1,h=-1===f.indexOf(" ",c.startOffset)?f:f.indexOf(" ",c.startOffset);c.setStart(c.commonAncestorContainer,g),c.setEnd(c.commonAncestorContainer,h),c.surroundContents(e),d.addRange(c)}else c.surroundContents(e),d.removeAllRanges(),d.addRange(c)}else b.error("Internet Explorer?")},this.getContent=function(){return this.viewHTML&&this.setContent(this.original.value),this.events.filter("getContent",this.editorDoc.body.innerHTML)},this.events={_events:{},bind:function(a,b){typeof this._events.eventName!="object"&&(this._events[a]=[]),this._events[a].push(b)},trigger:function(b,c){if(typeof this._events.eventName=="object"){var d=this.editor;a.each(this._events[b],function(a,b){typeof b=="function"&&b.apply(d,c)})}},filter:function(b,c){if(typeof this._events[b]=="object"){var d=this.editor,e=Array.prototype.slice.call(arguments,1);a.each(this._events[b],function(a,b){typeof b=="function"&&(c=b.apply(d,e))})}return c}},this.getElementByAttributeValue=function(b,c,d){var e,f,g=this.editorDoc.getElementsByTagName(b);for(e=0;e<g.length;e+=1){f=g[e].getAttribute(c),a.browser.msie&&(f=f.substr(f.length-d.length));if(f===d)return g[e]}return!1},this.getInternalRange=function(){var a=this.getInternalSelection();return a?a.rangeCount&&a.rangeCount>0?a.getRangeAt(0):a.createRange?a.createRange():null:null},this.getInternalSelection=function(){if(this.editor.get(0).contentWindow){if(this.editor.get(0).contentWindow.getSelection)return this.editor.get(0).contentWindow.getSelection();if(this.editor.get(0).contentWindow.selection)return this.editor.get(0).contentWindow.selection}return this.editorDoc.getSelection?this.editorDoc.getSelection():this.editorDoc.selection?this.editorDoc.selection:null},this.getRange=function(){var a=this.getSelection();if(!a)return null;if(a.rangeCount&&a.rangeCount>0)a.getRangeAt(0);else if(a.createRange)return a.createRange();return null},this.getSelection=function(){return window.getSelection?window.getSelection():window.document.selection},this.ui.grow=function(){var b=this.self,c=a(b.editorDoc.body),d=a.browser.msie?c[0].scrollHeight:c.height()+2+20,e=b.ui.initialHeight,f=Math.max(d,e);return f=Math.min(f,b.options.maxHeight),b.editor.attr("scrolling",f<b.options.maxHeight?"no":"auto"),c.css("overflow",f<b.options.maxHeight?"hidden":""),b.editor.get(0).height=f,b},this.init=function(b,c){var d=this,e=a(b).closest("form"),f=b.width||b.clientWidth||0,g=b.height||b.clientHeight||0;this.options=this.extendOptions(c),this.original=b,this.ui.toolbar=a(this.options.toolbarHtml),a.browser.msie&&parseInt(a.browser.version,10)<8&&(this.options.autoGrow=!1),f===0&&b.cols&&(f=b.cols*8+21),g===0&&b.rows&&(g=b.rows*16+16),this.editor=a(window.location.protocol==="https:"?'<iframe src="javascript:false;"></iframe>':"<iframe></iframe>").attr("frameborder","0"),this.options.iFrameClass?this.editor.addClass(this.options.iFrameClass):(this.editor.css({minHeight:(g-6).toString()+"px",width:f>50?(f-8).toString()+"px":""}),a.browser.msie&&parseInt(a.browser.version,10)<7&&this.editor.css("height",g.toString()+"px")),this.editor.attr("tabindex",a(b).attr("tabindex")),this.element=a("<div/>").addClass("wysiwyg"),this.options.iFrameClass||this.element.css({width:f>0?f.toString()+"px":"100%"}),a(b).hide().before(this.element),this.viewHTML=!1,this.initialContent=a(b).val(),this.ui.initFrame(),this.options.resizeOptions&&a.fn.resizable&&this.element.resizable(a.extend(!0,{alsoResize:this.editor},this.options.resizeOptions)),this.options.autoSave&&e.bind("submit.wysiwyg",function(){d.autoSaveFunction()}),e.bind("reset.wysiwyg",function(){d.resetFunction()})},this.ui.initFrame=function(){var b=this.self,c,d,e;b.ui.appendControls(),b.element.append(b.ui.toolbar).append(a("<div><!-- --></div>").css({clear:"both"})).append(b.editor),b.editorDoc=b.innerDocument();if(b.isDestroyed)return null;b.ui.designMode(),b.editorDoc.open(),b.editorDoc.write(b.options.html.replace(/INITIAL_CONTENT/,function(){return b.wrapInitialContent()})),b.editorDoc.close(),a.wysiwyg.plugin.bind(b),a(b.editorDoc).trigger("initFrame.wysiwyg"),a(b.editorDoc).bind("click.wysiwyg",function(a){b.ui.checkTargets(a.target?a.target:a.srcElement)}),a(b.original).focus(function(){if(a(this).filter(":visible").length===0)return;b.ui.focus()}),a(b.editorDoc).keydown(function(a){var c;if(a.keyCode===8){c=/^<([\w]+)[^>]*>(<br\/?>)?<\/\1>$/;if(c.test(b.getContent()))return a.stopPropagation(),!1}return!0}),a.browser.msie?b.options.brIE&&a(b.editorDoc).keydown(function(a){if(a.keyCode===13){var c=b.getRange();return c.pasteHTML("<br/>"),c.collapse(!1),c.select(),!1}return!0}):a(b.editorDoc).keydown(function(a){var c;if(a.ctrlKey||a.metaKey)for(c in b.controls)if(b.controls[c].hotkey&&b.controls[c].hotkey.ctrl&&a.keyCode===b.controls[c].hotkey.key)return b.triggerControl.apply(b,[c,b.controls[c]]),!1;return!0}),b.options.plugins.rmFormat.rmMsWordMarkup&&a(b.editorDoc).bind("keyup.wysiwyg",function(c){(c.ctrlKey||c.metaKey)&&86===c.keyCode&&a.wysiwyg.rmFormat&&("object"==typeof b.options.plugins.rmFormat.rmMsWordMarkup?a.wysiwyg.rmFormat.run(b,{rules:{msWordMarkup:b.options.plugins.rmFormat.rmMsWordMarkup}}):a.wysiwyg.rmFormat.run(b,{rules:{msWordMarkup:{enabled:!0}}}))}),b.options.autoSave&&a(b.editorDoc).keydown(function(){b.autoSaveFunction()}).keyup(function(){b.autoSaveFunction()}).mousedown(function(){b.autoSaveFunction()}).bind(a.support.noCloneEvent?"input.wysiwyg":"paste.wysiwyg",function(){b.autoSaveFunction()}),b.options.autoGrow&&(b.options.initialMinHeight!==null?b.ui.initialHeight=b.options.initialMinHeight:b.ui.initialHeight=a(b.editorDoc).height(),a(b.editorDoc.body).css("border","1px solid white"),d=function(){b.ui.grow()},a(b.editorDoc).keyup(d),a(b.editorDoc).bind("editorRefresh.wysiwyg",d),b.ui.grow()),b.options.css&&(String===b.options.css.constructor?a.browser.msie?(c=b.editorDoc.createStyleSheet(b.options.css),a(c).attr({media:"all"})):(c=a("<link/>").attr({href:b.options.css,media:"all",rel:"stylesheet",type:"text/css"}),a(b.editorDoc).find("head").append(c)):b.timers.initFrame_Css=window.setTimeout(function(){a(b.editorDoc.body).css(b.options.css)},0)),b.initialContent.length===0&&("function"==typeof b.options.initialContent?b.setContent(b.options.initialContent()):b.setContent(b.options.initialContent)),b.options.maxLength>0&&a(b.editorDoc).keydown(function(c){a(b.editorDoc).text().length>=b.options.maxLength&&a.inArray(c.which,b.validKeyCodes)===-1&&c.preventDefault()}),a.each(b.options.events,function(c,d){a(b.editorDoc).bind(c+".wysiwyg",function(a){d.apply(b.editorDoc,[a,b])})}),a.browser.msie?a(b.editorDoc).bind("beforedeactivate.wysiwyg",function(){b.savedRange=b.getInternalRange()}):a(b.editorDoc).bind("blur.wysiwyg",function(){b.savedRange=b.getInternalRange()}),a(b.editorDoc.body).addClass("wysiwyg"),b.options.events&&b.options.events.save&&(e=b.options.events.save,a(b.editorDoc).bind("keyup.wysiwyg",e),a(b.editorDoc).bind("change.wysiwyg",e),a.support.noCloneEvent?a(b.editorDoc).bind("input.wysiwyg",e):(a(b.editorDoc).bind("paste.wysiwyg",e),a(b.editorDoc).bind("cut.wysiwyg",e)));if(b.options.xhtml5&&b.options.unicode){var f={ne:8800,le:8804,para:182,xi:958,darr:8595,nu:957,oacute:243,Uacute:218,omega:969,prime:8242,pound:163,igrave:236,thorn:254,forall:8704,emsp:8195,lowast:8727,brvbar:166,alefsym:8501,nbsp:160,delta:948,clubs:9827,lArr:8656,Omega:937,Auml:196,cedil:184,and:8743,plusmn:177,ge:8805,raquo:187,uml:168,equiv:8801,laquo:171,rdquo:8221,Epsilon:917,divide:247,fnof:402,chi:967,Dagger:8225,iacute:237,rceil:8969,sigma:963,Oslash:216,acute:180,frac34:190,lrm:8206,upsih:978,Scaron:352,part:8706,exist:8707,nabla:8711,image:8465,prop:8733,zwj:8205,omicron:959,aacute:225,Yuml:376,Yacute:221,weierp:8472,rsquo:8217,otimes:8855,kappa:954,thetasym:977,harr:8596,Ouml:214,Iota:921,ograve:242,sdot:8901,copy:169,oplus:8853,acirc:226,sup:8835,zeta:950,Iacute:205,Oacute:211,crarr:8629,Nu:925,bdquo:8222,lsquo:8216,apos:39,Beta:914,eacute:233,egrave:232,lceil:8968,Kappa:922,piv:982,Ccedil:199,ldquo:8220,Xi:926,cent:162,uarr:8593,hellip:8230,Aacute:193,ensp:8194,sect:167,Ugrave:217,aelig:230,ordf:170,curren:164,sbquo:8218,macr:175,Phi:934,Eta:919,rho:961,Omicron:927,sup2:178,euro:8364,aring:229,Theta:920,mdash:8212,uuml:252,otilde:245,eta:951,uacute:250,rArr:8658,nsub:8836,agrave:224,notin:8713,ndash:8211,Psi:936,Ocirc:212,sube:8838,szlig:223,micro:181,not:172,sup1:185,middot:183,iota:953,ecirc:234,lsaquo:8249,thinsp:8201,sum:8721,ntilde:241,scaron:353,cap:8745,atilde:227,lang:10216,__replacement:65533,isin:8712,gamma:947,Euml:203,ang:8736,upsilon:965,Ntilde:209,hearts:9829,Alpha:913,Tau:932,spades:9824,dagger:8224,THORN:222,"int":8747,lambda:955,Eacute:201,Uuml:220,infin:8734,rlm:8207,Aring:197,ugrave:249,Egrave:200,Acirc:194,rsaquo:8250,ETH:208,oslash:248,alpha:945,Ograve:210,Prime:8243,mu:956,ni:8715,real:8476,bull:8226,beta:946,icirc:238,eth:240,prod:8719,larr:8592,ordm:186,perp:8869,Gamma:915,reg:174,ucirc:251,Pi:928,psi:968,tilde:732,asymp:8776,zwnj:8204,Agrave:192,deg:176,AElig:198,times:215,Delta:916,sim:8764,Otilde:213,Mu:924,uArr:8657,circ:710,theta:952,Rho:929,sup3:179,diams:9830,tau:964,Chi:935,frac14:188,oelig:339,shy:173,or:8744,dArr:8659,phi:966,iuml:239,Lambda:923,rfloor:8971,iexcl:161,cong:8773,ccedil:231,Icirc:206,frac12:189,loz:9674,rarr:8594,cup:8746,radic:8730,frasl:8260,euml:235,OElig:338,hArr:8660,Atilde:195,Upsilon:933,there4:8756,ouml:246,oline:8254,Ecirc:202,yacute:253,auml:228,permil:8240,sigmaf:962,iquest:191,empty:8709,pi:960,Ucirc:219,supe:8839,Igrave:204,yen:165,rang:10217,trade:8482,lfloor:8970,minus:8722,Zeta:918,sub:8834,epsilon:949,yuml:255,Sigma:931,Iuml:207,ocirc:244};b.events.bind("getContent",function(a){return a.replace(/&(?:amp;)?(?!amp|lt|gt|quot)([a-z][a-z0-9]*);/gi,function(a,b){f[b]||(b=b.toLowerCase(),f[b]||(b="__replacement"));var c=f[b];return String.fromCharCode(c)})})}a(b.original).trigger("ready.jwysiwyg",[b.editorDoc,b])},this.innerDocument=function(){var a=this.editor.get(0);if(a.nodeName.toLowerCase()==="iframe"){if(a.contentDocument)return a.contentDocument;if(a.contentWindow)return a.contentWindow.document;if(this.isDestroyed)return null;b.error("Unexpected error in innerDocument")}return a},this.insertHtml=function(b){var c,d;return!b||b.length===0?this:(a.browser.msie?(this.ui.focus(),this.editorDoc.execCommand("insertImage",!1,"#jwysiwyg#"),c=this.getElementByAttributeValue("img","src","#jwysiwyg#"),c&&a(c).replaceWith(b)):a.browser.mozilla?1===a(b).length?(d=this.getInternalRange(),d.deleteContents(),d.insertNode(a(b).get(0))):this.editorDoc.execCommand("insertHTML",!1,b):this.editorDoc.execCommand("insertHTML",!1,b)||(this.editor.focus(),this.editorDoc.execCommand("insertHTML",!1,b)),this.saveContent(),this)},this.parseControls=function(){var b=this;return a.each(this.options.controls,function(c,d){a.each(d,function(d){if(-1===a.inArray(d,b.availableControlProperties))throw c+'["'+d+'"]: property "'+d+'" not exists in Wysiwyg.availableControlProperties'})}),this.options.parseControls?this.options.parseControls.call(this):this.options.controls},this.removeFormat=function(){return a.browser.msie&&this.ui.focus(),this.options.removeHeadings&&this.editorDoc.execCommand("formatBlock",!1,"<p>"),this.editorDoc.execCommand("removeFormat",!1,null),this.editorDoc.execCommand("unlink",!1,null),a.wysiwyg.rmFormat&&a.wysiwyg.rmFormat.enabled&&("object"==typeof this.options.plugins.rmFormat.rmMsWordMarkup?a.wysiwyg.rmFormat.run(this,{rules:{msWordMarkup:this.options.plugins.rmFormat.rmMsWordMarkup}}):a.wysiwyg.rmFormat.run(this,{rules:{msWordMarkup:{enabled:!0}}})),this},this.ui.removeHoverClass=function(){a(this).removeClass("wysiwyg-button-hover")},this.resetFunction=function(){this.setContent(this.initialContent)},this.saveContent=function(){if(this.viewHTML)return;if(this.original){var b,c;b=this.getContent(),this.options.rmUnwantedBr&&(b=b.replace(/<br\/?>$/,"")),this.options.replaceDivWithP&&(c=a("<div/>").addClass("temp").append(b),c.children("div").each(function(){var b=a(this),c=b.find("p"),d;if(0===c.length){c=a("<p></p>");if(this.attributes.length>0)for(d=0;d<this.attributes.length;d+=1)c.attr(this.attributes[d].name,b.attr(this.attributes[d].name));c.append(b.html()),b.replaceWith(c)}}),b=c.html()),a(this.original).val(b),this.options.events&&this.options.events.save&&this.options.events.save.call(this)}return this},this.setContent=function(a){return this.editorDoc.body.innerHTML=a,this.saveContent(),this},this.triggerControl=function(a,c){var d=c.command||a,e=c.arguments||[];if(c.exec)c.exec.apply(this);else{this.ui.focus(),this.ui.withoutCss();try{this.editorDoc.execCommand(d,!1,e)}catch(f){b.error(f)}}this.options.autoSave&&this.autoSaveFunction()},this.triggerControlCallback=function(b){a(window).trigger("trigger-"+b+".wysiwyg",[this])},this.ui.withoutCss=function(){var b=this.self;if(a.browser.mozilla)try{b.editorDoc.execCommand("styleWithCSS",!1,!1)}catch(c){try{b.editorDoc.execCommand("useCSS",!1,!0)}catch(d){}}return b},this.wrapInitialContent=function(){var a=this.initialContent,b=a.match(/<\/?p>/gi);return b?a:"<p>"+a+"</p>"}}"use strict";var b=window.console?window.console:{log:a.noop,error:function(b){a.error(b)}},c="prop"in a.fn&&"removeProp"in a.fn;a.wysiwyg={messages:{noObject:"Something goes wrong, check object"},addControl:function(b,c,d){return b.each(function(){var b=a(this).data("wysiwyg"),e={},f;if(!b)return this;e[c]=a.extend(!0,{visible:!0,custom:!0},d),a.extend(!0,b.options.controls,e),f=a(b.options.toolbarHtml),b.ui.toolbar.replaceWith(f),b.ui.toolbar=f,b.ui.appendControls()})},clear:function(b){return b.each(function(){var b=a(this).data("wysiwyg");if(!b)return this;b.setContent("")})},console:b,destroy:function(b){return b.each(function(){var b=a(this).data("wysiwyg");if(!b)return this;b.destroy()})},document:function(b){var c=b.data("wysiwyg");return c?a(c.editorDoc):undefined},getContent:function(a){var b=a.data("wysiwyg");return b?b.getContent():undefined},init:function(b,c){return b.each(function(){var b=a.extend(!0,{},c),e;if("textarea"!==this.nodeName.toLowerCase()||a(this).data("wysiwyg"))return;e=new d,e.init(this,b),a.data(this,"wysiwyg",e),a(e.editorDoc).trigger("afterInit.wysiwyg")})},insertHtml:function(b,c){return b.each(function(){var b=a(this).data("wysiwyg");if(!b)return this;b.insertHtml(c)})},plugin:{listeners:{},bind:function(b){var c=this;a.each(this.listeners,function(d,e){var f,g;for(f=0;f<e.length;f+=1)g=c.parseName(e[f]),a(b.editorDoc).bind(d+".wysiwyg",{plugin:g},function(c){a.wysiwyg[c.data.plugin.name][c.data.plugin.method].apply(a.wysiwyg[c.data.plugin.name],[b])})})},exists:function(b){var c;return"string"!=typeof b?!1:(c=this.parseName(b),!a.wysiwyg[c.name]||!a.wysiwyg[c.name][c.method]?!1:!0)},listen:function(b,c){var d;return d=this.parseName(c),!a.wysiwyg[d.name]||!a.wysiwyg[d.name][d.method]?!1:(this.listeners[b]||(this.listeners[b]=[]),this.listeners[b].push(c),!0)},parseName:function(a){var b;return"string"!=typeof a?!1:(b=a.split("."),2>b.length?!1:{name:b[0],method:b[1]})},register:function(c){return c.name||b.error("Plugin name missing"),a.each(a.wysiwyg,function(a){a===c.name&&b.error("Plugin with name '"+c.name+"' was already registered")}),a.wysiwyg[c.name]=c,!0}},removeFormat:function(b){return b.each(function(){var b=a(this).data("wysiwyg");if(!b)return this;b.removeFormat()})},save:function(b){return b.each(function(){var b=a(this).data("wysiwyg");if(!b)return this;b.saveContent()})},selectAll:function(a){var b=a.data("wysiwyg"),c,d,e;if(!b)return this;c=b.editorDoc.body,window.getSelection?(e=b.getInternalSelection(),e.selectAllChildren(c)):(d=c.createTextRange(),d.moveToElementText(c),d.select())},setContent:function(b,c){return b.each(function(){var b=a(this).data("wysiwyg");if(!b)return this;b.setContent(c)})},triggerControl:function(c,d){return c.each(function(){var c=a(this).data("wysiwyg");if(!c)return this;c.controls[d]||b.error("Control '"+d+"' not exists"),c.triggerControl.apply(c,[d,c.controls[d]])})},support:{prop:c},utils:{extraSafeEntities:[["<",">","'",'"'," "],[32]],encodeEntities:function(b){var c=this,d,e=[];return this.extraSafeEntities[1].length===0&&a.each(this.extraSafeEntities[0],function(a,b){c.extraSafeEntities[1].push(b.charCodeAt(0))}),d=b.split(""),a.each(d,function(b){var f=d[b].charCodeAt(0);a.inArray(f,c.extraSafeEntities[1])&&(f<65||f>127||f>90&&f<97)?e.push("&#"+f+";"):e.push(d[b])}),e.join("")}}},a.wysiwyg.dialog=function(b,c){var d=b&&b.options&&b.options.dialog?b.options.dialog:c.theme?c.theme:"default",e=new a.wysiwyg.dialog.createDialog(d),f=this,g=a(f);return this.options={modal:!0,draggable:!0,title:"Title",content:"Content",width:"auto",height:"auto",open:!1,close:!1},this.isOpen=!1,a.extend(this.options,c),this.object=e,this.open=function(){this.isOpen=!0,e.init.apply(f,[]);var a=e.show.apply(f,[]);g.trigger("afterOpen",[a])},this.show=function(){this.isOpen=!0,g.trigger("beforeShow");var a=e.show.apply(f,[]);g.trigger("afterShow")},this.hide=function(){this.isOpen=!1,g.trigger("beforeHide");var a=e.hide.apply(f,[]);g.trigger("afterHide",[a])},this.close=function(){this.isOpen=!1;var a=e.hide.apply(f,[]);g.trigger("beforeClose",[a]),e.destroy.apply(f,[]),g.trigger("afterClose",[a])},this.options.open&&g.bind("afterOpen",this.options.open),this.options.close&&g.bind("afterClose",this.options.close),this},a.extend(!0,a.wysiwyg.dialog,{_themes:{},_theme:"",register:function(b,c){a.wysiwyg.dialog._themes[b]=c},deregister:function(b){delete a.wysiwyg.dialog._themes[b]},createDialog:function(b){return new a.wysiwyg.dialog._themes[b]}}),a(function(){jQuery.ui&&a.wysiwyg.dialog.register("jqueryui",function(){var b=this;this._$dialog=null,this.init=function(){var c=this,d=this.options.content;typeof d=="object"&&(typeof d.html=="function"?d=d.html():typeof d.toString=="function"&&(d=d.toString())),b._$dialog=a("<div></div>").attr("title",this.options.title).html(d);var e=this.options.height=="auto"?300:this.options.height,f=this.options.width=="auto"?450:this.options.width;return b._$dialog.dialog({modal:this.options.modal,draggable:this.options.draggable,height:e,width:f}),b._$dialog
},this.show=function(){return b._$dialog.dialog("open"),b._$dialog},this.hide=function(){return b._$dialog.dialog("close"),b._$dialog},this.destroy=function(){return b._$dialog.dialog("destroy"),b._$dialog}}),a.wysiwyg.dialog.register("default",function(){var b=this;this._$dialog=null,this.init=function(){var c=this,d=this.options.content;typeof d=="object"&&(typeof d.html=="function"?d=d.html():typeof d.toString=="function"&&(d=d.toString())),b._$dialog=a('<div class="wysiwyg-dialog"></div>');var e=a('<div class="wysiwyg-dialog-topbar"><div class="wysiwyg-dialog-close-wrapper"></div><div class="wysiwyg-dialog-title">'+this.options.title+"</div></div>"),f=a('<a href="#" class="wysiwyg-dialog-close-button">X</a>');f.click(function(){c.close()}),e.find(".wysiwyg-dialog-close-wrapper").prepend(f);var g=a('<div class="wysiwyg-dialog-content">'+d+"</div>");b._$dialog.append(e).append(g);var h=this.options.height=="auto"?300:this.options.height,i=this.options.width=="auto"?450:this.options.width;return b._$dialog.hide().css({width:i,height:h,left:(a(window).width()-i)/2,top:(a(window).height()-h)/3}),a("body").append(b._$dialog),b._$dialog},this.show=function(){this.options.modal&&b._$dialog.wrap('<div class="wysiwyg-dialog-modal-div"></div>');if(this.options.draggable){var c=!1;b._$dialog.find("div.wysiwyg-dialog-topbar").bind("mousedown",function(b){b.preventDefault(),a(this).css({cursor:"move"});var d=a(this),e=a(this).parents(".wysiwyg-dialog"),f=b.pageX-parseInt(e.css("left"),10),g=b.pageY-parseInt(e.css("top"),10);c=!0,a(this).css({cursor:"move"}),a(document).bind("mousemove",function(a){a.preventDefault(),c&&e.css({top:a.pageY-g,left:a.pageX-f})}).bind("mouseup",function(b){b.preventDefault(),c=!1,d.css({cursor:"auto"}),a(document).unbind("mousemove").unbind("mouseup")})})}return b._$dialog.show(),b._$dialog},this.hide=function(){return b._$dialog.hide(),b._$dialog},this.destroy=function(){return this.options.modal&&b._$dialog.unwrap(),this.options.draggable&&b._$dialog.find("div.wysiwyg-dialog-topbar").unbind("mousedown"),b._$dialog.remove(),b._$dialog}})}),a.fn.wysiwyg=function(c){var d=arguments,e;if("undefined"!=typeof a.wysiwyg[c])return d=Array.prototype.concat.call([d[0]],[this],Array.prototype.slice.call(d,1)),a.wysiwyg[c].apply(a.wysiwyg,Array.prototype.slice.call(d,1));if("object"==typeof c||!c)return Array.prototype.unshift.call(d,this),a.wysiwyg.init.apply(a.wysiwyg,d);if(a.wysiwyg.plugin.exists(c))return e=a.wysiwyg.plugin.parseName(c),d=Array.prototype.concat.call([d[0]],[this],Array.prototype.slice.call(d,1)),a.wysiwyg[e.name][e.method].apply(a.wysiwyg[e.name],Array.prototype.slice.call(d,1));b.error("Method '"+c+"' does not exist on jQuery.wysiwyg.\nTry to include some extra controls or plugins")},a.fn.getWysiwyg=function(){return a.data(this,"wysiwyg")}})(jQuery);