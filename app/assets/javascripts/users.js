// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

$(document).ready(function () {

  var locationButton = $("#location-button");

  locationButton.click(function () {

    var opts = {
      color: '#FFF',
      lines: 11, // The number of lines to draw
      length: 4, // The length of each line
      width: 2, // The line thickness
      radius: 3 // The radius of the inner circle
    };
    var target = document.getElementById('loading-spinner');
    var spinner = new Spinner(opts).spin(target);

    if (!navigator.geolocation) {
      spinner.stop();
    }

    navigator.geolocation.getCurrentPosition(
      function (pos) {
        spinner.stop();
        redirectToCoordinates(pos.coords.latitude, pos.coords.longitude);
      },
      function (error) {
        spinner.stop();
        alert('Couldn\'t fetch your location.\n\n'+error.message);
      },
      {maximumAge: 300000, timeout: 1000}
    );

  });

});

function getBaseUrl() {
  var getUrl = window.location;
  return getUrl.protocol + "//" + getUrl.host + "/" + getUrl.pathname.split('/')[1];
}

function redirectToCoordinates(latitude, longitude) {
  var baseUrl = getBaseUrl();

  var completeUrl = baseUrl + 'shows/' + latitude + '/' + longitude;

  window.location.href = completeUrl;

}