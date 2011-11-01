(function($){
  $('fieldset[data-association]').nestedAssociations();

  $('input[type=file]').livequery(function(){
    if ($(this).data('upload-path')) {
      $(this).ajaxyUpload({
        url     : $(this).data('upload-path'),
        success : function(data){
          var fieldset = $(this).closest('fieldset');
          $('input[id$=cache]', fieldset).val(data.file_cache || data.logo_file_cache);
          // $('img', fieldset).attr('src', data.image.thumb.url);
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
})(jQuery)
