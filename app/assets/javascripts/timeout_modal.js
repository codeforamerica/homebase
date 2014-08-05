// timeout_modal

var INTERVAL_TIME_IN_MS = 60000; // 1 minute
var DISPLAY_MODAL_TIME_IN_S = 7;
var RESET_TIME_IN_S = DISPLAY_MODAL_TIME_IN_S + 3;

var idleTime = 0;
$(document).ready(function($) 
  {


      //Increment the idle time counter every minute.
      var idleInterval = setInterval(timerIncrement, INTERVAL_TIME_IN_MS);


      //Zero the idle timer on mouse movement.
      $(this).mousemove(function (e) {
          idleTime = 0;
      });
      $(this).keypress(function (e) {
          idleTime = 0;
      });
    
});

// call timeout modal after 7 minutes
function show_modal() 
{
  $('#timeoutModal').modal();
}

function timerIncrement() {
  // Only if not at the root or if it is at root, only count if selection has been made
  if (document.location.pathname != "/" || (document.location.pathname == "/" && document.getElementsByClassName('btn-success').length > 0))
  {
    idleTime++;
    if (idleTime == DISPLAY_MODAL_TIME_IN_S)
    {
      show_modal();
    } else if (idleTime == RESET_TIME_IN_S)
    {
      location.href = "http://" + document.location.host;
    }
  }
}