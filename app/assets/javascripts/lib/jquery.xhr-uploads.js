/*
 * jQuery XHR upload plugin
 * http://github.com/maca
 *
 * Copyright 2011, Macario Ortega
 * Dual licensed under the MIT or GPL Version 2 licenses.
 *
 */

(function($){
  $.fn.ajaxyUpload = function(opts) {
    var settings  = {
      error      : $.noop, 
      success    : $.noop,
      start      : $.noop,
      complete   : $.noop,
      spinner    : {color : '#555', lines : 6, length : 2, width : 9, radius : 6}
    };

    // $(this).closest('form').attr('enctype', 'multipart/form-data');

    return $(this).each(function(){
      var fileInput = $(this);
      if (opts) { $.extend(settings, opts); }

      fileInput.attr("multiple", "multiple");

      // xhrUpload callback, this is triggered below only if the browser has hxr upload
      // capabilities
      fileInput.bind('xhrUpload', function(){
        var self = this;
        $.each(this.files, function(index, file){
          var advance = $('<div>').addClass('inline-upload-advance');
          var pBar    = $('<div>').addClass('inline-upload-progress-bar').append(advance);

          if ((advance.css('height').match(/\d/)[0]|0) == 0) { advance.css('height', '10px'); };
          advance.css('background-color', advance.css('background-color') || '#33a');
          advance.css('width', '0px');

          if ((pBar.css('width').match(/\d/)[0]|0) == 0) { pBar.css('width', '200px'); };
          pBar.css('background-color', pBar.css('background-color') || '#fff');
          pBar.css('border', pBar.css('border') || '1px solid #BBB');

          fileInput.after(pBar);
          console.log(file);

          var xhrUpload = $.ajax({
            type : "POST",
            url  : settings.url,
            xhr  : function(){
              var xhr = $.ajaxSettings.xhr();
              xhr.upload.onprogress = function(rpe) {
                var progress = (rpe.loaded / rpe.total * 100 >> 0) + '%';
                advance.css('width', progress);
              };
              xhr.onloadstart = function(){
                settings.start.apply(self);
              };
              return xhr;
            },
            beforeSend : function(xhr){
              // here we set custom headers for the rack middleware, first one tells the Rack app we are doing
              // an xhr upload, the two others are self explanatory
              xhr.setRequestHeader("X-XHR-Upload", "1");
              xhr.setRequestHeader("X-File-Name", file.name || file.fileName);
              xhr.setRequestHeader("X-File-Size", file.fileSize);
            },
            success : function(data, status, xhr) {
              settings.success.apply(self, [data, status, xhr]);
            },
            error : function(xhr, text, error) {
              if (xhr.status == 422) {
                settings.error.apply(self, [$.parseJSON(xhr.responseText)]);
              } else if (text != 'abort') {
                settings.error.apply(self);
              };
            },
            complete : function(xhr, status) {
              fileInput.after(fileInput.clone(false)).remove();
              settings.complete.apply(self);
              pBar.remove();
            },
            contentType : "application/octet-stream",
            dataType    : "json",
            processData : false,
            data        : file 
          });

          $(self).bind('cancelUpload', function(){
            xhrUpload.abort();
            return true;
          })
        });
      });

      // set an iframeUpload callback as fallback for older browsers
      fileInput.bind('iframeUpload', function(){
        var input   = $("<input type='file' class='inline-upload-input'>").attr('name', 'file');
        var iframe  = $("<iframe class='inline-upload-catcher'>").hide().attr('name', 'inline-upload-catcher-' + new Date().getTime());
        var spinner = $('<div>').addClass('spinner'); // TODO: don't use image.
        var auth    = $("<input type='hidden' name='authenticity_token'>").val($('[name=csrf-token]').attr('content')); // Rails authenticity token
        var form    = $("<form enctype='multipart/form-data' method='post'>").addClass('inline-upload-form').append(input).append(auth);
        form.attr('target', iframe.attr('name'));

        new Spinner(settings.spinner).spin(spinner[0]);

        if ((spinner.css('height').match(/\d/)[0]|0) == 0) { spinner.css('height', '20px'); };
        if ((spinner.css('width').match(/\d/)[0]|0) == 0) { spinner.css('width', '20px'); };

        $(this).after(form).after(iframe).hide();

        input.bind('complete', function(event, data){
          if (data.errors) {
            settings.error.apply(this, [data]);
          } else {
            settings.success.apply(this, [data]);
          };
          $(this).nextAll('.spinner').remove();
          settings.complete.apply(this);
        });

        input.change(function(){
          settings.start.apply(this);
          $(this).after(spinner);
          form.attr('action', settings.url).submit();
        });

        iframe.load(function(){
          input.trigger('complete', [$.parseJSON($(this).contents().text())]);
        });
      });

      // Not used just to check browser capabilities
      var xhr = $.ajaxSettings.xhr();
      // If the browser has xhr upload capabilities trigger xhrUpload otherwise fallback to iframe upload
      if (this.files && xhr && xhr.upload && (xhr.upload.onprogress !== undefined) && window.FileReader) {
        fileInput.change(function(){ $(this).trigger('xhrUpload') });
      } else {
        fileInput.trigger('iframeUpload');
      };
    })
  };
})(jQuery);


// Spin JS by Felix Gnass
// fgnass.github.com/spin.js#v1.2.1
(function(a,b,c){function n(a){var b={x:a.offsetLeft,y:a.offsetTop};while(a=a.offsetParent)b.x+=a.offsetLeft,b.y+=a.offsetTop;return b}function m(a,b){for(var d in b)a[d]===c&&(a[d]=b[d]);return a}function l(a,b){for(var c in b)a.style[k(a,c)||c]=b[c];return a}function k(a,b){var e=a.style,f,g;if(e[b]!==c)return b;b=b.charAt(0).toUpperCase()+b.slice(1);for(g=0;g<d.length;g++){f=d[g]+b;if(e[f]!==c)return f}}function j(a,b,c,d){var g=["opacity",b,~~(a*100),c,d].join("-"),h=.01+c/d*100,j=Math.max(1-(1-a)/b*(100-h),a),k=f.substring(0,f.indexOf("Animation")).toLowerCase(),l=k&&"-"+k+"-"||"";e[g]||(i.insertRule("@"+l+"keyframes "+g+"{"+"0%{opacity:"+j+"}"+h+"%{opacity:"+a+"}"+(h+.01)+"%{opacity:1}"+(h+b)%100+"%{opacity:"+a+"}"+"100%{opacity:"+j+"}"+"}",0),e[g]=1);return g}function h(a,b,c){c&&!c.parentNode&&h(a,c),a.insertBefore(b,c||null);return a}function g(a,c){var d=b.createElement(a||"div"),e;for(e in c)d[e]=c[e];return d}var d=["webkit","Moz","ms","O"],e={},f;h(b.getElementsByTagName("head")[0],g("style"));var i=b.styleSheets[b.styleSheets.length-1],o=function q(a){if(!this.spin)return new q(a);this.opts=m(a||{},{lines:12,length:7,width:5,radius:10,color:"#000",speed:1,trail:100,opacity:.25,fps:20})},p=o.prototype={spin:function(a){this.stop();var b=this,c=b.el=l(g(),{position:"relative"}),d,e;a&&(e=n(h(a,c,a.firstChild)),d=n(c),l(c,{left:(a.offsetWidth>>1)-d.x+e.x+"px",top:(a.offsetHeight>>1)-d.y+e.y+"px"})),c.setAttribute("aria-role","progressbar"),b.lines(c,b.opts);if(!f){var i=b.opts,j=0,k=i.fps,m=k/i.speed,o=(1-i.opacity)/(m*i.trail/100),p=m/i.lines;(function q(){j++;for(var a=i.lines;a;a--){var d=Math.max(1-(j+a*p)%m*o,i.opacity);b.opacity(c,i.lines-a,d,i)}b.timeout=b.el&&setTimeout(q,~~(1e3/k))})()}return b},stop:function(){var a=this.el;a&&(clearTimeout(this.timeout),a.parentNode&&a.parentNode.removeChild(a),this.el=c);return this}};p.lines=function(a,b){function e(a,d){return l(g(),{position:"absolute",width:b.length+b.width+"px",height:b.width+"px",background:a,boxShadow:d,transformOrigin:"left",transform:"rotate("+~~(360/b.lines*c)+"deg) translate("+b.radius+"px"+",0)",borderRadius:(b.width>>1)+"px"})}var c=0,d;for(;c<b.lines;c++)d=l(g(),{position:"absolute",top:1+~(b.width/2)+"px",transform:"translate3d(0,0,0)",opacity:b.opacity,animation:f&&j(b.opacity,b.trail,c,b.lines)+" "+1/b.speed+"s linear infinite"}),b.shadow&&h(d,l(e("#000","0 0 4px #000"),{top:"2px"})),h(a,h(d,e(b.color,"0 0 1px rgba(0,0,0,.1)")));return a},p.opacity=function(a,b,c){b<a.childNodes.length&&(a.childNodes[b].style.opacity=c)},function(){var a=l(g("group"),{behavior:"url(#default#VML)"}),b;if(!k(a,"transform")&&a.adj){for(b=4;b--;)i.addRule(["group","roundrect","fill","stroke"][b],"behavior:url(#default#VML)");p.lines=function(a,b){function k(a,d,i){h(f,h(l(e(),{rotation:360/b.lines*a+"deg",left:~~d}),h(l(g("roundrect",{arcsize:1}),{width:c,height:b.width,left:b.radius,top:-b.width>>1,filter:i}),g("fill",{color:b.color,opacity:b.opacity}),g("stroke",{opacity:0}))))}function e(){return l(g("group",{coordsize:d+" "+d,coordorigin:-c+" "+ -c}),{width:d,height:d})}var c=b.length+b.width,d=2*c,f=e(),i=~(b.length+b.radius+b.width)+"px",j;if(b.shadow)for(j=1;j<=b.lines;j++)k(j,-2,"progid:DXImageTransform.Microsoft.Blur(pixelradius=2,makeshadow=1,shadowopacity=.3)");for(j=1;j<=b.lines;j++)k(j);return h(l(a,{margin:i+" 0 0 "+i,zoom:1}),f)},p.opacity=function(a,b,c,d){var e=a.firstChild;d=d.shadow&&d.lines||0,e&&b+d<e.childNodes.length&&(e=e.childNodes[b+d],e=e&&e.firstChild,e=e&&e.firstChild,e&&(e.opacity=c))}}else f=k(a,"animation")}(),a.Spinner=o})(window,document)
// Spin JS
