// This is a manifest file that'll be compiled into including all the files listed below.
// Add new JavaScript/Coffee code in separate files in this directory and they'll automatically
// be included in the compiled file accessible from http://example.com/assets/application.js
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
//= require jquery
//= require jquery_ujs
//= require_tree .

$(function(){
  $('fieldset[data-association]').nestedAssociations(function(){
    $(this).closest('fieldset.question').find('fieldset.answer').each(function(index){
      $('input.answer-position', $(this)).val(index);
    })
  });

  $('a.publish-survey').click(function(){
    var publishLink = $(this)
    $.ajax({
      type : 'POST',
      url : publishLink.attr('href'),
      data : {'_method' : 'PUT'},
      success : function(){
        publishLink.detach();
      }
    })
    return false;
  });

  $('input[type=file]').livequery(function(){
    if ($(this).data('upload-path')) {
      $(this).ajaxyUpload({
        url     : $(this).data('upload-path'),
        success : function(data){
          var fieldset = $(this).closest('fieldset');
          var preview  = $('.preview img', fieldset);
          var file;

          $('input[id$=cache]', fieldset).val(data.file_cache || data.logo_file_cache || data.avatar_file_cache);
          file = data.file || data.logo_file || data.avatar_file;

          if (file && file.thumb) {
            $('.preview img', fieldset).attr('src', file.thumb.url);
          }
        },
        start : function() {
        },
        complete : function() {
        },
        error : function(data) {
        }
      });
    }
  });

  $("table[data-sortable]").tablesorter( { sortList: [[ 1, 0 ]] } )
  
  $('input.datepicker').datepicker({
    dateFormat: 'dd-mm-yy'
  });
  
  $('div.expander').expander({
    slicePoint: 300,
    widow: 2,
    expandText: 'Leer Mas',
    expandPrefix: '&hellip; ',
    expandEffect: 'fadeIn',
    expandSpeed: 600,
    collapseEffect: 'fadeOut',
    collapseSpeed: 200,
    userCollapse: true,
    userCollapseText: 'Cerrar',
    userCollapsePrefix: ''
  });

  $('a.toggle_comment_box').live('click', function(){
    $(this).closest('.comment').find('.comment-form').fadeIn(400, function(){
      $('textarea', $(this)).focus();
    });
    return false;
  });

  
  $("span.tip").twipsy({
    live: true
  })
  
  $("a[rel=tip]").twipsy({
    live: true,
    offset: 30,
  })

  $('textarea[data-editor]').wysiwyg({
    controls : {
      bold: {
        visible: true
      },
      italic: {
        visible: true
      },
      insertOrderedList: {
        visible: true
      },
      insertUnorderedList: {
        visible: true
      },
      html: {
        visible: true
      },
      createLink: {
        tooltip: "Create Link"
      },
      insertImage: {
        exec: function() {
          return $('#link-to-upload').click();
        },
        tooltip: "Insert image"
      },
      underline: {
        visible: false
      },
      strikeThrough: {
        visible: false
      },
      justifyLeft: {
        visible: false
      },
      justifyCenter: {
        visible: false
      },
      justifyRight: {
        visible: false
      },
      justifyFull: {
        visible: false
      },
      indent: {
        visible: false
      },
      outdent: {
        visible: false
      },
      subscript: {
        visible: false
      },
      superscript: {
        visible: false
      },
      undo: {
        visible: false
      },
      redo: {
        visible: false
      },
      insertHorizontalRule: {
        visible: false
      },
      h1: {
        visible: false
      },
      h4: {
        visible: false
      },
      h5: {
        visible: false
      },
      h6: {
        visible: false
      },
      cut: {
        visible: false
      },
      copy: {
        visible: false
      },
      paste: {
        visible: false
      },
      increaseFontSize: {
        visible: false
      },
      decreaseFontSize: {
        visible: false
      }
    }
  });

  /*elastic textareas*/
  $('input[type=text], textarea').live('focus', function(){
    if($(this).hasClass('textarea-size')) {
       $(this).elasticate(77,300);
       return;
    }
    if($(this).hasClass('span6')) {
       $(this).elasticate(114,300);
       return;
    }
  });
});

var toogleImageComment = function(textarea,url){
        var txtarea = $(textarea),
        parentNode = txtarea.parent();
        //parentNode.prepend('<div class="span1"><a href="/users/1"><img src="/uploads/xsmall_che.jpg" alt="Xsmall_che"></a></div>');
        parentNode.prepend('<div class="span1">'+url+'</div>');
        txtarea.removeClass('span8');
        txtarea.addClass('span7');
        txtarea.elasticate(26,200);
        /*retiramos los estilos cuando pierde el focus*/
        txtarea.blur(function(){
            var node = parentNode.children(':first-child');
            if(node.hasClass('span1') && (txtarea.val() =='')){ //si se trata de la imagen  y el textarea no tiene texto
                txtarea.removeClass('span7');
                txtarea.addClass('span8');
                node.remove();
            }
        });
};

var setupAutoScroll = function() {
  
  function nearBottomOfPage() {
    return $(window).scrollTop() > $(document).height() - $(window).height() - 200;
  }

  var page = 1;
  var loading = false;

  $(window).scroll(function(){
    if (loading) {
      return;
    }
    
    if(nearBottomOfPage()) {
      loading=true;
      page++;
      $.ajax({
        url: '?page=' + page,
        type: 'get',
        dataType: 'script',
        success: function() {
          $(window).sausage('draw');
          loading=false;
        }
      });
    }
  });
    
  $(window).sausage();
};
