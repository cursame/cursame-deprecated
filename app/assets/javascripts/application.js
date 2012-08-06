// This is a manifest file that'll be compiled into including all the files listed below.
// Add new JavaScript/Coffee code in separate files in this directory and they'll automatically
// be included in the compiled file accessible from http://example.com/assets/application.js
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
 
//= require jquery
//#=require jquery_ujs
//= require_tree

$(function(){
  // disabling buttons to avoid double posting
  $('.wall input[type=submit], .actions input[type=submit], .comments input[type=submit]').on("click", function(){
    $(this).attr('disabled', 'disabled');
    $(this).parents('form').submit();
    return false; //to disable double request in Firefox for the click
  });
  
  //lazy loading the members for the network
  $("img.network-members").lazyload({
    effect : "fadeIn"
  });

  // Survey form
  var questionAndAnswersFieldsets = $('fieldset[data-association="questions"], fieldset[data-association="answers"]');

  $('fieldset[data-association="questions"]').bind('setOrder', function(){
    $(this).closest('fieldset.questions').find('fieldset.question').each(function(index){
      $('input.question-position', $(this)).val(index);
    })
  });
  
  $('fieldset.new.question').click(function(){  
    $(this).addClass('question-select').siblings().removeClass('question-select'); 
  });
  
  $('fieldset[data-association="answers"]').bind('setOrder', function(){
    $(this).closest('fieldset.question').find('fieldset.answer').each(function(index){
      $('input.answer-position', $(this)).val(index);
    })
  });

  questionAndAnswersFieldsets.nestedAssociations({
    add : function(){
      var fields = $(this).trigger('setOrder').css('cursor', 'move');
      // var fields = $(this).trigger('setOrder');

      $('html, body').animate({
        scrollTop: fields.offset().top
      }, 200);

      $('input.answer-uuid', fields).val(UUIDjs.create().toString());
    },
    remove : function(){
      $('input.answer-uuid[type=radio]', $(this)).removeAttr('checked');
    }
  });

  $('a.remove-associated-record').livequery(function(){
    $(this).addClass('delete-survey');
  })

  questionAndAnswersFieldsets.livequery(function(){
    var sortableSettings = {
      stop        : function(){ $(this).trigger('setOrder') },
      axis        : 'y',
      tolerance   : 'pointer',
      scrollSpeed : 40,
      items       : 'fieldset'
      /* cancel      : 'a'  */
    } 
    $(this).sortable(sortableSettings).children('associated').css('cursor', 'move');
    // $(this).sortable(sortableSettings).children('.associated');
  });
  // Survey Form
  
  // Assets
  $('fieldset[data-association="assets"]').nestedAssociations();
  // Assets 

  $('a.publish-survey').click(function(){
    var publishLink = $(this);
    $.ajax({
      type : 'POST',
      url : publishLink.attr('href'),
      data : {'_method' : 'PUT'},
      success : function(){
        var newState = $('<span>').text(publishLink.data('new-state'));
        publishLink.before(newState).detach();
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

          $('input[id$=cache]', fieldset).val(data.file_cache || data.logo_file_cache || data.avatar_file_cache || data.course_logo_file_cache);
          file = data.file || data.logo_file || data.avatar_file || data.course_logo_file;

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
    $(this).closest('.comment').find('.comment-form').fadeIn(400);
    return false;
  });

  $("a[rel=tooltip]").twipsy({
    live: true,
    placement: "right"
  });

  $("span.tip").twipsy({
    live: true
  });
  
  $("a[rel=member-tip]").twipsy({
    live: true,
    offset: 170
  });

  $("a[rel=dashboard-tip]").twipsy({
    live: true,
    offset: 15
  });

  $("a[rel=tip]").twipsy({
    live: true,
    offset: 30
  });
  
  $("fieldset[rel=drag_tip]").twipsy({
    live: true,
    placement: 'right',
    offset: 10,
    delayOut: 4
  });

  $('textarea[data-editor]').wysiwyg({
    css: '/assets/bootstrap.css',
    controls : {
      bold: { visible: true },
      italic: { visible: true },
      insertOrderedList: { visible: true },
      insertUnorderedList: { visible: true },
      createLink: { tooltip: "Crear Link" },
      insertImage: {
        visible: false,
        exec: function() {
          return $('#link-to-upload').click();
        },
        tooltip: "Insert image"
      },
      removeFormat: { visible: true },
      underline: { visible: false },
      strikeThrough: { visible: false },
      justifyLeft: { visible: false },
      justifyCenter: { visible: false },
      justifyRight: { visible: false },
      justifyFull: { visible: false },
      indent: { visible: false },
      outdent: { visible: false },
      subscript: { visible: false },
      superscript: { visible: false },
      undo: { visible: false },
      redo: { visible: false },
      insertHorizontalRule: { visible: false },
      h1: { visible: false },
      h4: { visible: false },
      h5: { visible: false },
      h6: { visible: false },
      cut: { visible: false },
      copy: { visible: false },
      paste: { visible: false },
      increaseFontSize: { visible: false },
      decreaseFontSize: { visible: false }      
    }
  });

 /* Fancybox */

 $('.terms').fancybox({
   maxHeight: 500,
   maxWidth: 800
 });

  /* TextAreaExpander textareas */
  
  $("textarea.textarea-size").TextAreaExpander(77, 300);
  
  // End of TextAreaExpander areas.

  /* Toggle domain registry on supervisor config form */

  if ($("#network_registry_domain").val() !== "") {
    $("#network_private_registry").attr('checked', 'true');
  } else {
    $("#network_registry_domain_input").hide();
  }

  $("#network_private_registry").click(function() {
    if ($("#network_registry_domain_input").is(':visible')) {
      $("#network_registry_domain").val("");
      return $("#network_registry_domain_input").slideUp();
    } else {
      return $("#network_registry_domain_input").slideDown();
    }
  });

});

var toggleImageComment = function(textarea, url){
        var txtarea = $(textarea),
        parentNode = txtarea.parent();
        parentNode.prepend('<div class="comment-img">' + url + '</div>');
        txtarea.removeClass('span8');
        txtarea.addClass('span7');
        txtarea.TextAreaExpander(26,200);
        
        /* Removes styles when out of focus */
        txtarea.blur(function(){
            var node = parentNode.children(':first-child');
            if(node.hasClass('comment-img')){
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
$('.submittable').live('change', function() {
  $(this).parents('form:first').submit();
});


function generarVector(value,arraysize){
	var randomnumber,aux=value,vector = [];
	for (var i = 0; i < arraysize; i++){
		randomnumber=Math.floor(Math.random()*aux+1);		
		vector.push(randomnumber);
		aux = aux - randomnumber;
	}
	return vector;
}

/*highcharts*/
function renderUserGraph(title, renderTo,subtitle,yText,value,fecha) {
	var mes = fecha.split("/"),
	 	meses = [ "January", "February", "March", "April", "May", "June","July", "August", "September", "October", "November", "December" ];
		meses = meses.slice(mes[0]-1,12),
	 	usuariosTotales = value,
	 	estudiantesTotales = value - (parseInt(value/40) + 1),
		maestrosTotales = parseInt(value/40) + 1 ;
		
		//$('#'+renderTo+'t').html('<strong>Teachers count:</strong>'+maestrosTotales*2)
	
	var aEstudiantes = generarVector(estudiantesTotales,mes[0]),
		aMaestros = generarVector(maestrosTotales,mes[0]),
		aUsuarios = [];
		
		for(var i = 0; i < mes[0];i++){			
			aUsuarios .push(aEstudiantes[i]+aMaestros[i]);
		}
	 
    new Highcharts.Chart({
        chart: {
            renderTo: renderTo ,
            type: 'column'
        },
        title: {
            text: title
        },
        subtitle: {
            text: subtitle || 'Tipos'
        },
        xAxis: {
            categories: meses
        },
        yAxis: {
            min: 0,
            title: {
                text: yText || 'Unidades'
            }
        },
        legend: {
            backgroundColor: '#FFFFFF',
            shadow: true
        },

        tooltip: {
            formatter: function () {
                return '' + this.x + ': ' + this.y + '';
            }
        },
        plotOptions: {
            column: {
                pointPadding: 0.2,
                borderWidth: 0
            }
        },
        series: [{
            name: 'Usuarios',
            data: aUsuarios
        }, {
            name: 'Estudiantes',
            data: aEstudiantes
        }, {
            name: 'Maestro',
            data: aMaestros
        }]
    });
}

function renderUsersGraph(renderTo, value) {
    new Highcharts.Chart({
        chart: {
            renderTo: renderTo ,
            type: 'column'
        },
        title: {
            text: 'Cúrsame'
        },
        subtitle: {
            text: 'Usuarios en cúrsame'
        },
        xAxis: {
            categories: ['Resúmenes']
        },
        yAxis: {
            min: 0,
            title: {
                text: 'Unidades'
            }
        },
        legend: {
            backgroundColor: '#FFFFFF',
            shadow: true
        },

        tooltip: {
            formatter: function () {
                return ''  + this.y + '';
            }
        },
        plotOptions: {
            column: {
                pointPadding: 0.2,
                borderWidth: 0
            }
        },
        series: [{
            name: 'Redes',
            data: [value[0]]
        }, {
            name: 'Usuarios',
            data: [value[1]]
        }, {
            name: 'Supervisores',
            data: [value[2]]
        },{
	       	name: 'Maestros',
	        data: [value[3]]
	    },{
		    name: 'Estudiantes',
		    data: [value[4]]
		}]
    });
}
function renderCoursesGraph(renderTo, value) {
    new Highcharts.Chart({
        chart: {
            renderTo: renderTo ,
            type: 'column'
        },
        title: {
            text: 'Cúrsame'
        },
        subtitle: {
            text: 'Cursos en cúrsame'
        },
        xAxis: {
            categories: ['Resúmenes']
        },
        yAxis: {
            min: 0,
            title: {
                text: 'Unidades'
            }
        },
        legend: {
            backgroundColor: '#FFFFFF',
            shadow: true
        },

        tooltip: {
            formatter: function () {
                return ''  + this.y + '';
            }
        },
        plotOptions: {
            column: {
                pointPadding: 0.2,
                borderWidth: 0
            }
        },
        series: [{
            name: 'Cursos',
            data: [value[0]]
        }, {
            name: 'Públicos',
            data: [value[1]]
        }, {
            name: 'Privados',
            data: [value[2]]
        },{
	       	name: 'Tareas',
	        data: [value[3]]
	    },{
		    name: 'Discusiones',
		    data: [value[4]]
		},{
			name: 'Cuestionarios',
			data: [value[5]]
		}]
    });
}

function renderCommentsGraph(renderTo, value) {
    new Highcharts.Chart({
        chart: {
            renderTo: renderTo ,
            type: 'line'
        },
        title: {
            text: 'Cúrsame'
        },
        subtitle: {
            text: 'Comentarios en cúrsame'
        },
        xAxis: {
            categories: ['Resúmenes']
        },
        yAxis: {
            min: 0,
            title: {
                text: 'Unidades'
            }
        },
        legend: {
            backgroundColor: '#FFFFFF',
            shadow: true
        },

        tooltip: {
            formatter: function () {
                return ''  + this.y + '';
            }
        },
        plotOptions: {
            column: {
                pointPadding: 0.2,
                borderWidth: 0
            }
        },
        series: [{
            name: 'Comentarios',
            data: [value[0]]
        }, {
            name: 'Comentarios en tareas',
            data: [value[1]]
        }, {
            name: 'Comentarios en iscusiones',
            data: [value[2]]
        },{
	       	name: 'Comentarios en muro usuarios',
	        data: [value[3]]
	    },{
		    name: 'Comentarios muro cursos',
		    data: [value[4]]
		}]
    });
}

