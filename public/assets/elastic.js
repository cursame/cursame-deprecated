(function(a){a.fn.TextAreaExpander=function(b,c){function e(a){a=a.target||a;var b=a.value.length,c=a.offsetWidth;if(b!=a.valLength||c!=a.boxWidth){d&&(b<a.valLength||c!=a.boxWidth)&&(a.style.height="0px");var e=Math.max(a.expandMin,Math.min(a.scrollHeight,a.expandMax));a.style.overflow=a.scrollHeight>e?"auto":"hidden",a.style.height=e+"px",a.valLength=b,a.boxWidth=c}return!0}var d=!a.browser.msie&&!a.browser.opera;return this.each(function(){if(this.nodeName.toLowerCase()!="textarea")return;var d=this.className.match(/expand(\d+)\-*(\d+)*/i);this.expandMin=b||(d?parseInt("0"+d[1],10):0),this.expandMax=c||(d?parseInt("0"+d[2],10):99999),e(this),this.Initialized||(this.Initialized=!0,a(this).css("padding-top",0).css("padding-bottom",0),a(this).bind("keyup",e).bind("focus",e))}),this}})(jQuery);