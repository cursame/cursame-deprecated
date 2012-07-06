/**
 * Controls: Link plugin
 *
 * Depends on jWYSIWYG
 *
 * By: Esteban Beltran (academo) <sergies@gmail.com>
 */
(function(a){"use strict";if(undefined===a.wysiwyg)throw"wysiwyg.link.js depends on $.wysiwyg";a.wysiwyg.controls||(a.wysiwyg.controls={}),a.wysiwyg.controls.link={init:function(b){var c=this,d,e,f,g,h,i,j,k,l,m,n,o;j={legend:"Insert Link",url:"Link URL",title:"Link Title",target:"Link Target",submit:"Insert Link",reset:"Cancel"},i='<form class="wysiwyg"><fieldset><legend>{legend}</legend><label>{url}: <input type="text" name="linkhref" value=""/></label><label>{title}: <input type="text" name="linktitle" value=""/></label><label>{target}: <input type="text" name="linktarget" value=""/></label><input type="submit" class="button" value="{submit}"/> <input type="reset" value="{reset}"/></fieldset></form>';for(k in j)a.wysiwyg.i18n&&(l=a.wysiwyg.i18n.t(j[k],"dialogs.link"),l===j[k]&&(l=a.wysiwyg.i18n.t(j[k],"dialogs")),j[k]=l),m=new RegExp("{"+k+"}","g"),i=i.replace(m,j[k]);g={self:b.dom.getElement("a"),href:"http://",title:"",target:""},g.self&&(g.href=g.self.href?g.self.href:g.href,g.title=g.self.title?g.self.title:"",g.target=g.self.target?g.self.target:"");if(a.fn.dialog){d=a(i),d.find("input[name=linkhref]").val(g.href),d.find("input[name=linktitle]").val(g.title),d.find("input[name=linktarget]").val(g.target);if(a.browser.msie)try{e=d.appendTo(b.editorDoc.body)}catch(p){e=d.appendTo("body")}else e=d.appendTo("body");e.dialog({modal:!0,open:function(c,d){a("input:submit",e).click(function(c){c.preventDefault();var d=a('input[name="linkhref"]',e).val(),f=a('input[name="linktitle"]',e).val(),i=a('input[name="linktarget"]',e).val(),j,k;b.options.controlLink.forceRelativeUrls&&(j=window.location.protocol+"//"+window.location.hostname,0===d.indexOf(j)&&(d=d.substr(j.length))),g.self?"string"==typeof d&&(d.length>0?a(g.self).attr("href",d).attr("title",f).attr("target",i):a(g.self).replaceWith(g.self.innerHTML)):(a.browser.msie&&b.ui.returnRange(),h=b.getRangeText(),k=b.dom.getElement("img"),h&&h.length>0||k?(a.browser.msie&&b.ui.focus(),"string"==typeof d&&(d.length>0?b.editorDoc.execCommand("createLink",!1,d):b.editorDoc.execCommand("unlink",!1,null)),g.self=b.dom.getElement("a"),a(g.self).attr("href",d).attr("title",f),a(g.self).attr("target",i)):b.options.messages.nonSelection&&window.alert(b.options.messages.nonSelection)),b.saveContent(),a(e).dialog("close")}),a("input:reset",e).click(function(b){b.preventDefault(),a(e).dialog("close")})},close:function(a,b){e.dialog("destroy"),e.remove()}})}else g.self?(f=window.prompt("URL",g.href),b.options.controlLink.forceRelativeUrls&&(n=window.location.protocol+"//"+window.location.hostname,0===f.indexOf(n)&&(f=f.substr(n.length))),"string"==typeof f&&(f.length>0?a(g.self).attr("href",f):a(g.self).replaceWith(g.self.innerHTML))):(h=b.getRangeText(),o=b.dom.getElement("img"),h&&h.length>0||o?a.browser.msie?(b.ui.focus(),b.editorDoc.execCommand("createLink",!0,null)):(f=window.prompt(j.url,g.href),b.options.controlLink.forceRelativeUrls&&(n=window.location.protocol+"//"+window.location.hostname,0===f.indexOf(n)&&(f=f.substr(n.length))),"string"==typeof f&&(f.length>0?b.editorDoc.execCommand("createLink",!1,f):b.editorDoc.execCommand("unlink",!1,null))):b.options.messages.nonSelection&&window.alert(b.options.messages.nonSelection)),b.saveContent();a(b.editorDoc).trigger("editorRefresh.wysiwyg")}},a.wysiwyg.createLink=function(b,c){return b.each(function(){var b=a(this).data("wysiwyg"),d;return b?!c||c.length===0?this:(d=b.getRangeText(),d&&d.length>0?(a.browser.msie&&b.ui.focus(),b.editorDoc.execCommand("unlink",!1,null),b.editorDoc.execCommand("createLink",!1,c)):b.options.messages.nonSelection&&window.alert(b.options.messages.nonSelection),this):this})}})(jQuery);