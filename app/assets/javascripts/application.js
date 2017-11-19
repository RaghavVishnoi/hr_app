// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require bootstrap-sprockets
//= require moment
//= require fullcalendar
//= require admin
//= require cable
//= require demo
//= require helpers
//= require jquery.dataTables
//= require bootstrap-material-datetimepicker
//= require dataTables.bootstrap
//= require dataTables.buttons.min
//= require jquery.inputmask.bundle
//= require jquery-datatable
//= require materialize
//= require sweetalert.min
//= require script
//= require cable
//= require signature_pad
//= require signature
//= require_tree .



// $(document).ready(function () {


//   $('#camera_wrap').camera({
//     height: '68.125%',
//     thumbnails: false,
//     pagination: true,
//     fx: 'simpleFade',
//     loader: 'none',
//     hover: false,
//     navigation: false,
//     playPause: false,
//     minHeight: "975px",
//   });
// });
// this.App = {}

// App.cable = ActionCable.createConsumer();


$(document).ready(function(){  
   $('#calendar').each(function(){
    var calendar = $(this);
    calendar.fullCalendar({
      header: {
        left: 'prev,next today',
        center: 'title',
        right: 'month,agendaWeek,agendaDay'
      },

      eventMouseover: function (data, event, view) {

            tooltip = '<div class="tooltiptopicevent" style="width:auto;height:auto;background:#feb811;position:absolute;z-index:10001;padding:10px 10px 10px 10px ;  line-height: 200%;">' + 'Title: ' + ': ' + data.title + '</br>' + 'Requested by ' + ': ' + data.assign + '</div>';


            $("body").append(tooltip);
            $(this).mouseover(function (e) {
                $(this).css('z-index', 10000);
                $('.tooltiptopicevent').fadeIn('500');
                $('.tooltiptopicevent').fadeTo('10', 1.9);
            }).mousemove(function (e) {
                $('.tooltiptopicevent').css('top', e.pageY + 10);
                $('.tooltiptopicevent').css('left', e.pageX + 20);
            });


        },

        eventMouseout: function (data, event, view) {
            $(this).css('z-index', 8);

            $('.tooltiptopicevent').remove();

        },
        dayClick: function () {
            tooltip.hide()
        },
        eventResizeStart: function () {
            tooltip.hide()
        },

        eventDragStart: function () {
            tooltip.hide()
        },
        viewDisplay: function () {
            tooltip.hide()
        },

      selectable: true,
      selectHelper: true,
      editable: false,
      eventLimit: true,
      events: '/events.json',





      eventClick: function(event, jsEvent, view) {
        $.getScript(event.edit_url, function() {});
      }

    })
  });

  $(document).on("change", "#question_question_type", function(){
    if($(this).val() == 'Choices'){
      $("#choices").show("slow");
      $("#choices-answer").find("select").removeAttr("disabled");
      $("#descriptive-answer").find("textarea").attr("disabled", "disabled");
      $("#descriptive-answer").hide();
      $("#choices-answer").show();
    } else {
      $("#choices").hide("hide");
      $("#choices-answer").find("select").attr("disabled", "disabled");
      $("#choices-answer").hide();
      $("#descriptive-answer").find("textarea").removeAttr("disabled");
      $("#descriptive-answer").show();
    }
  });

  // $(".form-date-select input[id^='leave_']").datetimepicker();
});

function notifyUser(text){
  $(".container-fluid").append('<div data-notify="container" class="bootstrap-notify-container alert alert-dismissible bg-black p-r-35 animated fadeInDown" role="alert" data-notify-position="top-right" style="width: 300px;display: inline-block; margin: 0px auto; position: fixed; transition: all 0.5s ease-in-out; z-index: 1031; top: 20px; right: 20px;"><span data-notify="icon"></span> <span data-notify="title"></span> <span data-notify="message" >'+text+'</span><a href="#" target="_blank" data-notify="url"></a></div>')
  $('.bootstrap-notify-container').delay(20000).fadeOut("slow", function () {
      $(this).next().fadeIn("slow");
  });
}











