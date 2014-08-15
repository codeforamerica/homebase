$(document).ready(function() {

  // trigger when user clicks any of the "select a project" buttons
  $ (".project").each(function(i) {

    // just focus on the button the user clicked
    $(this).click(function() {

      // get the id of the clicked button button, which will tell us what kind of project the user picked
      clickedButton = $(this).attr("id");

      // turn the id we got from clickedButton into a class, so we can show the correct "Your Project" sidebar icon
      chosenProject = (".").concat(clickedButton)

      // grab the class for the clickedButton, so we can add the success class and change its color
      clickedButtonClass = (".pick-").concat(clickedButton);

      // show the correct "Your Project" icon in sidebar
      $(chosenProject).toggleClass("displayed");

      // give the clicked button the success class, so it will change color
      $(clickedButtonClass).toggleClass("btn-success");

    });
  });
});