// enter_details

$(document).ready(function() 
{

    $("#contractor-yes-btn").click(function()
    {
        if(!$('.contractor-details').is(':visible'))
        {
            $(".contractor-details").fadeToggle("fast","swing");
        }
    });

    $("#contractor-no-btn").click(function()
    {
        if($('.contractor-details').is(':visible'))
        {
            $(".contractor-details").fadeToggle("fast","swing");
        }
    });

    // add bootstrap button toggle functionality
    $('.btn').button()

});