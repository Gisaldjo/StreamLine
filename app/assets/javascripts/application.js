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
//= require interactjs
//= require jquery
//= require rails-ujs
//= require activestorage
//= require turbolinks
//= require daterangepicker
//= require_tree .
//= require_self


// full calendar

var initialize_calendar;
initialize_calendar = function() {
  $('#calendar_body').each(function(){
    var calendar = $(this);
    calendar.fullCalendar({
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
            height: "auto",
            handleWindowResize: true,
            titleFormat: 'MMMM YYYY',
            minTime: '06:00:00', // Start time for the calendar
            maxTime: '25:30:00', // End time for the calendar
            columnHeaderFormat: 'ddd D',
            displayEventTime: true, // Display event time
            events: '/tasks.json',

            select: function(start, end) {
              $.getScript('/tasks/new', function() {
                $('#task_date_range').val(moment(start).format("MM/DD/YYYY HH:mm") + ' - ' + moment(end).format("MM/DD/YYYY HH:mm"))
                date_range_picker();
                $('.start_hidden').val(moment(start).format('YYYY-MM-DD HH:mm'));
                $('.end_hidden').val(moment(end).format('YYYY-MM-DD HH:mm'));
              });
      
              calendar.fullCalendar('unselect');
            },
      
            eventDrop: function(event, delta, revertFunc) {
              event_data = { 
                event: {
                  id: event.id,
                  start: event.start.format(),
                  end: event.end.format()
                }
              };
              $.ajax({
                  url: event.update_url,
                  data: event_data,
                  type: 'PATCH'
              });
            },
            
            eventClick: function(event, jsEvent, view) {
              $.getScript(event.edit_url, function() {
                $('#task_date_range').val(moment(event.start).format("MM/DD/YYYY HH:mm") + ' - ' + moment(event.end).format("MM/DD/YYYY HH:mm"))
                date_range_picker();
                $('.start_hidden').val(moment(event.start).format('YYYY-MM-DD HH:mm'));
                $('.end_hidden').val(moment(event.end).format('YYYY-MM-DD HH:mm'));
              });
            }
          });
        })
      };
$(document).on('turbolinks:load', initialize_calendar);

var date_range_picker;
date_range_picker = function() {
  $('.date-range-picker').each(function(){
    $(this).daterangepicker({
        autoApply: true,
        timePicker: true,
        timePickerIncrement: 5,
        alwaysShowCalendars: true,
        locale: {
          format: 'MM/DD/YYYY HH:mm'
        }
    }, function(start, end, label) {
      $('.start_hidden').val(start.format('YYYY-MM-DD HH:mm'));
      $('.end_hidden').val(end.format('YYYY-MM-DD HH:mm'));
    });
  })
};
$(document).on('turbolinks:load', date_range_picker);

//////////////////////////////////////////////////////////

/////              Notes                 /////////

// clicking on notes

//Closing notes on click outside of input

var click_outside_element_handler = function(event) {
  openNote = document.getElementById('new_note')
  submit = $(openNote).find("#form_submit")
  if(!!openNote) {
    if(!$(event.target).closest('#new_note').length) {
      submit.trigger('click')
    }       
  }
}


var note_click_event_handler = function(note_id) {
  $.get("/notes/"+note_id, null, 'script');
}

// $(document).on('turbolinks:load', function(){
//     $(".note").click(function() {
//         $("delete_button").click(function(event) {
//             event.stopPropagation();
//         });
//         note_click_event_handler($(this).attr('id'));
//    });
// });

// dragging and dropping notes

var dragMoveListener;

dragMoveListener = function(event) {
  var target = event.target,
  // keep the dragged position in the data-x/data-y attributes
  x = (parseFloat(target.getAttribute('data-x')) || 0) + event.dx,
  y = (parseFloat(target.getAttribute('data-y')) || 0) + event.dy;

// translate the element
  target.style.webkitTransform =
  target.style.transform =
  'translate(' + x + 'px, ' + y + 'px)';

// update the posiion attributes
  target.setAttribute('data-x', x);
  target.setAttribute('data-y', y);
};

window.dragMoveListener = dragMoveListener;


interact('*[data-draggable="true"]')
  .draggable({
    inertia: true,
    autoScroll: true,
    onmove: dragMoveListener,
    onend: function (event) {
      var textEl = event.target.querySelector('p');

      textEl && (textEl.textContent =
        'moved a distance of '
        + (Math.sqrt(Math.pow(event.pageX - event.x0, 2) +
                     Math.pow(event.pageY - event.y0, 2) | 0))
            .toFixed(2) + 'px');
    }
  })
  .on('tap', function(event) {
    // click_outside_element_handler(event);
    note_click_event_handler(event.currentTarget.id);
  })
  
$(document).click(function(event) { 
 click_outside_element_handler(event); 
});