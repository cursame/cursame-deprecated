// macario ortega
// github.com/maca
// mit licence

(function($){
  $('a.remove-associated-record').livequery('click', function(){
    $(this).siblings('input').attr('value', '1');
    $(this).closest('fieldset').slideUp();
    return false;
  });
  
  $.fn.nestedAssociations = function(callback){
    var self = $(this);
    var nested = self.find('[data-association]').filter(function(){
      return $(this).children('fieldset').size() == 1;
    });
    var associationFieldset = self.not(nested);
    callback = callback || $.noop;

    return associationFieldset.each(function(){
      var container    = $(this);
      var destroyLi    = container.children('fieldset').children('ol').children('li[id$=destroy_input]');
      var destroyLink  = $('<a href="#" class="btn danger small remove-associated-record">').text(destroyLi.first().text());
      var template     = container.children('fieldset.new').last().detach();
      var association  = container.attr('data-association');

      destroyLi.append(destroyLink);
      destroyLi.children('label').hide();

      template.bind('changeId', function(event, association, newId){
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
      });

      container.children('a.add_record').show().click(function(){
        var cleanTemplate = template.clone(true);
        cleanTemplate.trigger('changeId', [association, new Date().getTime()]);
        cleanTemplate.find('[data-association]').nestedAssociations(callback);

        $(this).before(cleanTemplate.hide());
        container.children().removeClass('last');
        callback.apply(cleanTemplate[0]);
        cleanTemplate.addClass('last').slideDown();
        return false;
      });
    });
  };
})(jQuery);
