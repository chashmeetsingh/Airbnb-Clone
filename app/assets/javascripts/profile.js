(function($) {
  'use strict';

  function parseDate(date) {
    var parts = date.split('-');
    return new Date(parts[0], parts[1], parts[2]);
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
        $('#form_errors').show('slow');
      } else {
        $('#booking_form').submit();
      }
    } else {
      $('#form_errors1').show('slow');
    }
  }

  $(document).ready(function() {
    $('#form_errors').hide();
    $('#form_errors1').hide();

    $('.request-booking').click(validate);

    // Phone Number
    $('#user_phone_no').mask('(999) 999-9999');
  });
})(jQuery);
