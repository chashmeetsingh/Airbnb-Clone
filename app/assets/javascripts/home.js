var autocomplete;

function initialize() {
  if ($('#autocomplete').length) {
    autocomplete = new google.maps.places.Autocomplete(
      (document.getElementById('autocomplete')), {
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
    console.log(place.geometry.location.lat());
    console.log(place.geometry.location.lng());
    $lng.val(place.geometry.location.lng());
    $lat.val(place.geometry.location.lat());
  }
}

google.maps.event.addDomListener(window, 'load', initialize);

function getCoordinates() {
  var coordinates = autocomplete.getPlace();
  $('#lng').val(coordinates.geometry.location.lng());
  $('#lat').val(coordinates.geometry.location.lat());
  $('#search_form').submit();
}

$(document).ready(function() {
  $('#form_errors').hide();
  $('#form_errors1').hide();

  if ($('#start_date').length) {
    $("#start_date").datepicker({
      minDate: 0,
      dateFormat: 'yy-mm-dd'
    });
  }

  if ($('#end_date').length) {
    $("#end_date").datepicker({
      minDate: 0,
      dateFormat: 'yy-mm-dd'
    });
  }
});

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

function parseDate(date) {
  var parts = date.split('-');
  return new Date(parts[0], parts[1], parts[2]);
}

jQuery(function($){
    $("#user_phone_no").mask("(999) 999-9999");
});
