$(document).ready(function() {
  $selectPet = $('.select-pet');

  $selectPet.click(function(e) {
    var $this = $(this);
    $selectPet.removeClass('active');
    $this.addClass('active');
    $('#dog_id').val($this.data('pet-id'));
    e.preventDefault();
  });
});
