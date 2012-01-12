// macario ortega
// github.com/maca
// mit licence

(function($){
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

    return associationFieldset.each(function(){
      var container    = $(this);
      var destroyLi    = container.children('fieldset').children('ol').children('li[id$=destroy_input]');
      var destroyLink  = $('<a href="#" class="btn danger small remove-associated-record">').text(destroyLi.first().text());
      var association  = container.attr('data-association');
      var template     = container.children('fieldset.new').last().detach();

      destroyLink.click(function(){
        var fieldset = $(this).closest('fieldset'); 
        $(this).siblings('input').attr('value', '1');
        fieldset.slideUp();
        settings.remove.apply(fieldset);
        return false;
      });

      destroyLi.append(destroyLink);
      destroyLi.children('label').hide();

      container.children('a.add_record').show().click(function(){
        var cleanTemplate = template.clone(true);
        $(this).before(cleanTemplate.hide());

        $(this).parents('fieldset[data-association]').each(function(){
          var association = $(this).attr('data-association');
          $(this).children('fieldset.new').each(function(){
            $(this).nestedAssociationsChangeId(association, new Date().getTime());
          })
        });

        container.children().removeClass('last');
        settings.add.apply(cleanTemplate[0]);
        cleanTemplate.addClass('last').slideDown();
        return false;
      });
    });
  };
})(jQuery);
