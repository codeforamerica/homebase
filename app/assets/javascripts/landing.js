$(document).ready(function() 
  {

  $ (".project").each(function(i) {
    //console.log("TEST!");
    //console.log(this);
    $(this).click(function() {
      // $(element.id).css("test", "test");
      // targeted = element.target.id
      // targeted_id = targeted.split("-");
      clickedButton = $(this).attr("id");
      clickedButtonId = ("#").concat(clickedButton)
      clickedButtonElement = (".").concat(clickedButton)
      clickedButtonActual = ("pick-").concat(clickedButton);

      console.log("CLICKED:");
      console.log(clickedButton);

      if(!$(clickedButtonElement).is(':visible')) {
        $(clickedButtonElement).fadeToggle("fast", "swing", function() {
          $(clickedButtonElement).css("display", "inline-block");
        });
        console.log("IS VISIBLE, TURNING OFF")
      }
      else {
        $(clickedButtonElement).fadeToggle("fast", "swing");
        console.log("IS INVISIBLE, TURNING OFF")
      }

      $(clickedButtonActual).toggleClass("btn-success");
      console.log("DONE:");
      console.log(clickedButtonActual)
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