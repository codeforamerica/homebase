// timeout_modal

$(document).ready(function($) 
  {

    // call timeout modal after 7 minutes
    function show_modal() 
    {
      $('#myModal').modal();
    }
    window.setTimeout(show_modal, 420000); // 7 minute delay before it calls the modal function

    // redirect to 1st step after 10 minutes
    window.setTimeout(function() 
      {
        location.href = "http://app.homebasefix.com/";
      },
      600000)

});