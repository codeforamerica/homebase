$(document).ready(function() {
  $ (".project").each(function(i) {
    $(this).click(function() {
      clickedButton = $(this).attr("id");
      buttonId = ("#").concat(clickedButton)
      chosenProject = (".").concat(clickedButton)
      clickedButtonClass = ("pick-").concat(clickedButton);

      $(chosenProject).toggleClass("displayed");
      $(clickedButtonClass).toggleClass("btn-success");
    });
  });

  /*
  $(".pick-addition").click(function()
    {
      $(".addition").fadeToggle("fast", "swing", function () {
        $(".addition").css("display", "inline-block");
      });
      $(".pick-addition").toggleClass("btn-success");
    });

  $(".pick-window").click(function()
    {
      $(".window").fadeToggle("fast","swing");
      $(".pick-window").toggleClass("btn-success");
    });  

  $(".pick-door").click(function()
    {
      $(".door").fadeToggle("fast","swing");
      $(".pick-door").toggleClass("btn-success");
    }); 

  $(".pick-wall").click(function()
    {
      $(".wall").fadeToggle("fast","swing");
      $(".pick-wall").toggleClass("btn-success");
    }); 

  $(".pick-siding").click(function()
    {
      $(".siding").fadeToggle("fast","swing");
      $(".pick-siding").toggleClass("btn-success");
    }); 

  $(".pick-floor").click(function()
    {
      $(".floor").fadeToggle("fast","swing");
      $(".pick-floor").toggleClass("btn-success");
    }); 

  $(".pick-cover").click(function()
    {
      $(".cover").fadeToggle("fast","swing");
      $(".pick-cover").toggleClass("btn-success");
    });  

  $(".pick-pool").click(function()
    {
      $(".pool").fadeToggle("fast","swing");
      $(".pick-pool").toggleClass("btn-success");
    }); 

  $(".pick-deck").click(function()
    {
      $(".deck").fadeToggle("fast","swing");
      $(".pick-deck").toggleClass("btn-success");
    }); 

  $(".pick-acs-struct").click(function()
    {
      $(".acs-struct").fadeToggle("fast","swing");
      $(".pick-acs-struct").toggleClass("btn-success");
    }); 
    */

 });