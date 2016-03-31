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

$(function() {
    if($('#start_date')) {
        $("#start_date").datepicker({ minDate: 0, dateFormat: 'yy-mm-dd'});
        $("#end_date").datepicker({ minDate: 0, dateFormat: 'yy-mm-dd'});
    }
});

$(document).ready(function() {
    $('#form_errors').hide();
});

function validate() {

    var date1 = $('#start_date').val();
    var date2 = $('#end_date').val();

    var startDate = parseDate(date1);
    var endDate = parseDate(date2);

    if ( startDate > endDate ) {
        $('#form_errors').show("slow");
    }
    else{
        $('#booking_form').submit();
    }
}

function parseDate(date) {
    var parts = date.split('-');
    return new Date(parts[0], parts[1], parts[2]);
}

