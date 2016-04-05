var autocomplete;
function initialize() {
    if ($('#autocomplete').length) {
        autocomplete = new google.maps.places.Autocomplete(
            (document.getElementById('autocomplete')),
            {types: ['geocode']});

        autocomplete.addListener('place_changed', fillInAddress);
    }
}

function fillInAddress() {
    var place = autocomplete.getPlace();
    console.log(place.geometry.location.lat());
    console.log(place.geometry.location.lng());

    if( $('#user_lng') && $('#user_lat') ) {
        $('#user_lng').val(place.geometry.location.lng());
        $('#user_lat').val(place.geometry.location.lat());
    }

}

google.maps.event.addDomListener(window, 'load', initialize);

function getCoordinates(){
    var coordinates = autocomplete.getPlace();
    $('#lng').val(coordinates.geometry.location.lng());
    $('#lat').val(coordinates.geometry.location.lat());
    $('#search_form').submit();
}

$(document).ready(function() {
    $('#form_errors').hide();
    $('#form_errors1').hide();
});

function validate() {

    $('#form_errors1').hide();
    $('#form_errors').hide();

    var date1 = $('#start_date').val();
    var date2 = $('#end_date').val();

    var startDate = parseDate(date1);
    var endDate = parseDate(date2);

    if(date1.length != 0) {
        if (startDate > endDate) {
            $('#form_errors').show("slow");
        }
        else {
            $('#booking_form').submit();
        }
    }
    else{
        $('#form_errors1').show("slow");
    }
}

function parseDate(date) {
    var parts = date.split('-');
    return new Date(parts[0], parts[1], parts[2]);
}

