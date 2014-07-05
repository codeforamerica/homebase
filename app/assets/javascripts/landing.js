$(document).ready(function() 
  {


  $(".pick-addition").click(function()
    {
      $(".addition").fadeToggle("fast","swing");
      $(".pick-addition").toggleClass("btn-success");
      $(".panel-info-addition").toggleClass("panel-success")
    });

  $(".pick-repair").click(function()
    {
      $(".repair").fadeToggle("fast","swing");
      $(".pick-repair").toggleClass("btn-success");
      $(".panel-info-repair").toggleClass("panel-success")
    });  

  $(".pick-cover").click(function()
    {
      $(".cover").fadeToggle("fast","swing");
      $(".pick-cover").toggleClass("btn-success");
      $(".panel-info-cover").toggleClass("panel-success")
    });  

  $(".pick-pool").click(function()
    {
      $(".pool").fadeToggle("fast","swing");
      $(".pick-pool").toggleClass("btn-success");
      $(".panel-info-pool").toggleClass("panel-success")
    }); 

    // @TODO refactor this unnecessary js out

    $(".roof-btn").click(function()
    {
      $(".roof").fadeToggle("fast","swing");
      $('.roof-btn').toggleClass("toggle-on");
    });

    $(".fence-btn").click(function()
    {
      $(".fence").fadeToggle("fast","swing");
      $('.fence-btn').toggleClass("toggle-on");
    });

    $(".repairs-btn").click(function()
    {
      $(".chimney").fadeToggle("fast","swing");
      $('.repairs-btn').toggleClass("toggle-on");
    });

    $(".addition-btn").click(function()
    {
      $(".addition").fadeToggle("fast","swing");
      $('.addition-btn').toggleClass("toggle-on");
    });



    

    $('.ha-waypoint').waypoint(function(direction) 
    {
      var $el = $(this);
      var percentage = $el.data(direction === 'down' ? 'animateDown' : 'animateUp');

      $('.waypoint').animate(
      {
        width: percentage,
      }, 
      {
        duration: 300,
      });

      $('.progress-percent').html(percentage)
        // $('.waypoint').removeClass("step-0 step-1").addClass(animClass);
      }, 
      { 
        offset: '70%' 
      });
 });