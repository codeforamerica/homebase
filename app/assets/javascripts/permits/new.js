// alert("new.js called"); // neither is this called in IE11
// alert("In new.js: " + document.referrer);
var selected_projects = [];

$(document).ready(function() {

  // trigger when user clicks any of the "select a project" buttons
  $ (".project").each(function(i) {

    // just focus on the button the user clicked
    $(this).click(function() {

      // get the id of the clicked button button, which will tell us what kind of project the user picked
      clickedButton = $(this).attr("id");

      // add in selected_projects array
      proj_index = selected_projects.indexOf(clickedButton);
      if (proj_index == -1) {
        // add item to array
        selected_projects.push(clickedButton);
      } else {
        // remove item from array
        selected_projects.splice(proj_index, 1);
      }

      console.log(selected_projects);

      // turn the id we got from clickedButton into a class, so we can show the correct "Your Project" sidebar icon
      chosenProject = (".").concat(clickedButton);

      // grab the class for the clickedButton, so we can add the success class and change its color
      clickedButtonClass = (".pick-").concat(clickedButton);

      // show the correct "Your Project" icon in sidebar
      $(chosenProject).toggleClass("displayed");

      // give the clicked button the success class, so it will change color
      $(clickedButtonClass).toggleClass("btn-success");

    });
  });
});

window.addEventListener('popstate', function(event) {
  console.log('popstate fired');
  console.log(event.state);
  if (event.state) {
    selected_projects = event.state["selected_projects"];
    for (i = 0; i < selected_projects.length; i++) {
      console.log(selected_projects[i]);
      clickedButtonClass = (".pick-").concat(selected_projects[i]);
      $(clickedButtonClass).toggleClass("btn-success", true);

      chosenProject = (".").concat(selected_projects[i]);
      $(chosenProject).toggleClass("displayed", true);

      proj_index = selected_projects.indexOf(selected_projects[i]);
      if (proj_index == -1) {
        selected_projects.push(selected_projects[i]);
      }

      selectedCheckBox = ("permit_selected_").concat(selected_projects[i]).replace("-", "_");
      document.getElementById(selectedCheckBox).checked = true;
    }
  }
});

  // $("btn-success").each(function()) {
  //   existingClickedButton = $(this).attr.("id");
  //   proj_index = selected_projects.indexOf(existingClickedButton);
  //   if (proj_index == -1) {
  //     selected_projects.push(existingClickedButton);
  //   }
  // };