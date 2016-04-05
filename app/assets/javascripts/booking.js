$(document).ready(function() {
  var $petList = $('#pet-list');
  var $dogId = $('#dog_id');

  $petList.click(function(e) {
    var activeClass = 'active';
    var $target = $(e.target);
    $('.list-group-item', $petList).removeClass(activeClass);
    $target.addClass(activeClass);
    $dogId.val($target.data('pet-id'));
    e.preventDefault();
  });

  $('#dogForm').submit(function(e) {
    e.preventDefault();

    var $name = $('#name');
    var $description = $('#description');

    console.log('aaa');

    if ($name.val()) {
      if ($description.val()) {
        $.post('/dog/api', {
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
              var content = '<a href class="list-group-item" data-pet-id="' + data['dog_id'] + '">' + data['dog_name'] + '</a>';
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
