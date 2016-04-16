$(document).ready(function() {
  var $petList = $('#pet-list');
  var $petId = $('#pet_id');

  $petList.click(function(e) {
    var activeClass = 'active';
    var $target = $(e.target);
    $('.list-group-item', $petList).removeClass(activeClass);
    $target.addClass(activeClass);
    $petId.val($target.data('pet-id'));
    e.preventDefault();
  });

  $('#petForm').submit(function(e) {
    e.preventDefault();

    var $name = $('#name');
    var $description = $('#description');

    if ($name.val()) {
      if ($description.val()) {
        $.post('/pets/api', {
            name: $name.val(),
            year: $('#year').val(),
            month: $('#month').val(),
            gender: $('#gender').val(),
            breed: $('#breed').val(),
            size: $('#size').val(),
            description: $description.val()
          },
          function(data, status, xhr) {
            if (xhr.status == 200) {
              var content = '<a href class="list-group-item" data-pet-id="' + data['pet_id'] + '">' + data['pet_name'] + '</a>';
              console.log(content);
              $petList.append(content);
              alert('added');
            }
            console.log(xhr.status);
          }
        )
      } else {
        alert('provide description');
      }
    } else {
      alert('name empty');
    }
  });
});
