// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

$(document).ready(function() {

    var locationButton = $( "#location-button" );

    locationButton.click(function() {

        var opts = {
            color: '#FFF',
            lines: 11, // The number of lines to draw
            length: 4, // The length of each line
            width: 2, // The line thickness
            radius: 3 // The radius of the inner circle
        };
        var target = document.getElementById('loading-spinner');
        var spinner = new Spinner(opts).spin(target);

        if(!navigator.geolocation) {
            spinner.stop();
        }

        navigator.geolocation.getCurrentPosition(function(pos) {
            geocoder = new google.maps.Geocoder();
            var latlng = new google.maps.LatLng(pos.coords.latitude,pos.coords.longitude);
            geocoder.geocode({'latLng': latlng}, function(results, status) {
                if (status == google.maps.GeocoderStatus.OK) {
                    //Check result 0
                    var result = results[0];
                    console.log(results);
                    //look for locality tag and administrative_area_level_1
                    var city = "";
                    var state = "";
                    var country = "";
                    for(var i=0, len=result.address_components.length; i<len; i++) {
                        var ac = result.address_components[i];
                        if(ac.types.indexOf("locality") >= 0) city = ac.long_name;
                        if(ac.types.indexOf("administrative_area_level_1") >= 0) state = ac.long_name;
                        if(ac.types.indexOf("country") >= 0) country = ac.short_name;
                    }
                    //only report if we got Good Stuff
                    if(city != '' && state != '') {
                        $("#city").val(city);
                        $("#state").val(state);
                        $("#country").val(country);
                    }
                }
                spinner.stop();
            });

        });

        $("#city").focus();

    });

    var showsForm = $("#shows-form");

    $("#city").focus();

    showsForm.submit(function(e) {
        e.preventDefault();

        var city = $("#city").val();
        var state = $("#state").val();
        var country = $("#country").val();

        city = encodeURIComponent(city).toLowerCase();
        state = encodeURIComponent(state).toLowerCase();

        var baseUrl = showsForm.attr('action');

        var completeUrl = baseUrl + '/' + country + '/' + state + '/' + city;

        window.location.href = completeUrl;

        console.log(baseUrl + '/' + country + '/' + state + '/' + city);


    });


});