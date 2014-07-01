// enter_repair

$(document).ready(function() 
{

    $("#window-yes-btn").click(function()
    {
        if(!$('.window-details').is(':visible'))
        {
            $(".window-details").fadeToggle("fast","swing");
        }
    });

    $("#window-no-btn").click(function()
    {
        if($('.window-details').is(':visible'))
        {
            $(".window-details").fadeToggle("fast","swing");
        }
    });

    $("#door-yes-btn").click(function()
    {
        if(!$('.door-details').is(':visible'))
        {
            $(".door-details").fadeToggle("fast","swing");
        }
    });

    $("#door-no-btn").click(function()
    {
        if($('.door-details').is(':visible'))
        {
            $(".door-details").fadeToggle("fast","swing");
        }
    });

    // add bootstrap button toggle functionality
    $('.btn').button()

});