// macario ortega
// github.com/maca
// mit licence

(function($){
  var idRandom = null;
  $.fn.nestedAssociationsChangeId = function(association, newId){
    $(this).find('[id], [for], [name]').each(function(){
      var tag = $(this);
      $.each(['id', 'for', 'name'], function(index, attribute){
        var value = tag.attr(attribute);
        if (value && attribute == 'name') { 
          var matcher = new RegExp('\\[' + association + '_attributes\\]\\[\\d+\\]');
          tag.attr(attribute, value.replace(matcher, '[' + association + '_attributes][' + newId + ']'));
        } else if (value) {
          var matcher = new RegExp(association + '_attributes_\\d+');
          tag.attr(attribute, value.replace(matcher, association + '_attributes_' + newId));
          console.log('voinas para los calvos'+newId);

        }; 
      });
    });
  };

  $.fn.nestedAssociations = function(opts){
    var self = $(this);
    var associationFieldset = self;
    var settings = {
      add    : $.noop,
      remove : $.noop
    }
    if (opts) { $.extend(settings, opts); }

    $(this).find('input[id$=_destroy]').closest('label').each(function(){
      var destroyLink  = $('<a href="#" class="remove-associated-record">').text($(this).text());
    
      destroyLink.click(function(){
        $(this).siblings('input').attr('value', '1');
        settings.remove.apply($(this).closest('fieldset').slideUp());
        return false;
      });

      $(this).hide().after(destroyLink);
    });

    return associationFieldset.each(function(){
      var container    = $(this);
      var association  = container.attr('data-association');
      var template     = container.children('fieldset.new').last().detach();

      container.children('a.add_record').show().click(function(){
        var cleanTemplate = template.clone(true);
        $(this).before(cleanTemplate.hide());

        $(this).parents('fieldset[data-association]').each(function(){
          var association = $(this).attr('data-association');
          $(this).children('fieldset.new').each(function(){
            idRandom = Math.ceil(Math.random()*5000);
            $(this).nestedAssociationsChangeId(association, idRandom);
          })
        });

        cleanTemplate.slideDown(function(){
          settings.add.apply(this);
        });
        return false;
      });
    });
  };
})(jQuery);