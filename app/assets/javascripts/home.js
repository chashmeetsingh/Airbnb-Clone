var autocomplete;
function initialize() {

    autocomplete = new google.maps.places.Autocomplete(
        (document.getElementById('autocomplete')),
        {types: ['geocode']});

    autocomplete.addListener('place_changed', fillInAddress);
}

function fillInAddress() {
    var place = autocomplete.getPlace();
    console.log(place.geometry.location.lat());
    console.log(place.geometry.location.lng());
}

google.maps.event.addDomListener(window, 'load', initialize);

function getCoordinates(){
    var coordinates = autocomplete.getPlace();
    $('#lng').val(coordinates.geometry.location.lng());
    $('#lat').val(coordinates.geometry.location.lat());
    $('#search_form').submit();
}