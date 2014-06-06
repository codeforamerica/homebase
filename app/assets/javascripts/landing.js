$(document).ready(function() 
  {

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