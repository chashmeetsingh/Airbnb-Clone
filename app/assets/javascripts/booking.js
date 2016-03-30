$(document).ready(function() {
  $selectPet = $('.select-pet');

  $selectPet.click(function(e) {
    var $this = $(this);
    $selectPet.removeClass('active');
    $this.addClass('active');
    $('#dog_id').val($this.data('pet-id'));
    e.preventDefault();
  });

  if ($('#bookButton').length) {
    var start_date = $('#start_date').val();
    var end_date = $('#end_date').val();
    var days = daysBetween(start_date, end_date);
    $('#noOfDays').val(days);
    $('#days').text(days);
    var perDayPrice = parseInt($('#perDayPrice').text(), 10);
    $('#totalCost').text('$' + (days * perDayPrice));
    //alert($('#totalCost').text());
    $('#perDayPrice').text('$' + perDayPrice);
  }
});

function daysBetween(date1, date2) {
  return Math.ceil((parseDate(date2) - parseDate(date1)) / (1000 * 3600 * 24)) + 1;
}

function parseDate(date) {
  var parts = date.split('-');
  return new Date(parts[0], parts[2], parts[1]);
}
