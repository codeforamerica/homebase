$(document).ready(function() {
  $ (".project").each(function(i) {
    $(this).click(function() {
      clickedButton = $(this).attr("id");
      buttonId = ("#").concat(clickedButton)
      chosenProject = (".").concat(clickedButton)
      clickedButtonClass = (".pick-").concat(clickedButton);

      $(chosenProject).toggleClass("displayed");
      $(clickedButtonClass).toggleClass("btn-success");
    });
  });
 });