// inspiration from http://stackoverflow.com/questions/8425701/ajax-mailchimp-signup-form-integration thread

$(document).ready(function() {
  
  $('#mc-embedded-subscribe').click(function(event) {
    
    // stop the form from submitting
    event.preventDefault();

    // grab the clicked button info, set the button state to loading
    var btn = $(this);
    btn.button('loading')

    // grab the form info
    var $form = $('form');

    // send the form
    register($form);

  });
});

function register($form) {

    console.log('EXECUTING FUNCTION!!!!');

    $.ajax({
        type: $form.attr('method'),
        url:  $form.attr('action'),
        data: $form.serialize(),
        cache: false,
        dataType: 'jsonp',
        jsonp: 'c',
        contentType: "application/json; charset=utf-8",
        error       : function(err) { 
          alert("Could not connect to the registration server. Please give it another try."); 
        },
        success     : function(data) {
            if (data.result != "success") {
              $('#mc-embedded-subscribe').button('reset'),
              $('#mc-embedded-subscribe').toggleClass('btn-warning')
              $('#mc-embedded-subscribe').html("There was a problem, click this again")
            } else {
              $('#mc-embedded-subscribe').button('reset'),
              $('#mc-embedded-subscribe').toggleClass('btn-success')
              $('#mc-embedded-subscribe').html('You\'re signed up!')

              // after a few seconds, dismiss the modal
              setTimeout(function() {
                $('#leanModal').modal('hide');
              },
              800);
            }
        }
    });
}