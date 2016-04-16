var autocomplete;

function parseDate(date) {
  var parts = date.split('-');
  return new Date(parts[0], parts[1], parts[2]);
}

function initialize() {
  var $autocomplete = $('#autocomplete');
  if ($autocomplete.length) {
    autocomplete = new google.maps.places.Autocomplete(
      $autocomplete[0], {
        types: ['geocode']
      });

    autocomplete.addListener('place_changed', fillInAddress);
  }
}

function fillInAddress() {
  var $lat = $('#user_lat');
  var $lng = $('#user_lng');
  var place;

  if ($lng && $lat) {
    place = autocomplete.getPlace();
    //console.log(place.geometry.location.lat());
    //console.log(place.geometry.location.lng());
    $lng.val(place.geometry.location.lng());
    $lat.val(place.geometry.location.lat());
  }
}

function getCoordinates() {
  var coordinates = autocomplete.getPlace();
  $('#lng').val(coordinates.geometry.location.lng());
  $('#lat').val(coordinates.geometry.location.lat());
  $('#search_form').submit();
}

function validate() {
  $('#form_errors1').hide();
  $('#form_errors').hide();

  var date1 = $('#start_date').val();
  var date2 = $('#end_date').val();

  var startDate = parseDate(date1);
  var endDate = parseDate(date2);

  if (date1.length != 0) {
    if (startDate > endDate) {
      $('#form_errors').show("slow");
    } else {
      $('#booking_form').submit();
    }
  } else {
    $('#form_errors1').show("slow");
  }
}

// Initialize Google Maps
google.maps.event.addDomListener(window, 'load', initialize);

$(document).ready(function() {
  $('#form_errors').hide();
  $('#form_errors1').hide();

  var $startDate = $('#start_date');
  var $endDate = $('#end_date');
  var datepickerOptions = {
    minDate: 0,
    dateFormat: 'yy-mm-dd'
  };

  if ($startDate.length) {
    $startDate.datepicker(datepickerOptions);
  }

  if ($endDate.length) {
    $endDate.datepicker(datepickerOptions);
  }

  // Phone Number
  $('#user_phone_no').mask('(999) 999-9999');
});
