// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require rails-ujs
//= require activestorage
//= require turbolinks
//= require_tree .
//= require_self

function eventCalendar() {
    return $('#calendar_body').fullCalendar({
      header: {
        left: 'prev,next today',
        center: 'title',
        right: 'month,agendaWeek,agendaDay',
      },
      defaultView: 'agendaWeek',
      selectable: true,
      selectHelper: true,
      editable: true,
      eventLimit: true,
      height: "parent",
      events: 'https://fullcalendar.io/demo-events.json'
    });
  };

  function clearCalendar() {
    $('#calendar_body').fullCalendar('delete'); 
    $('#calendar_body').html('');
  };

  var note_click_event_handler = function(note_id) {
    $.get($('#new_note').attr('action'), {id: note_id},null, 'script');
  }


  $(document).on('turbolinks:load', function(){
    eventCalendar();  
    $(".note").click(function() {
      note_click_event_handler($(this).attr('id'));
    });
  });

  $(document).on('turbolinks:before-cache', clearCalendar);