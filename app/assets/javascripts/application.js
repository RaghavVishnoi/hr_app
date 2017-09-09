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