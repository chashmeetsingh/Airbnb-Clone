function favourite(userId) {
  var $favourite = $('#favourite');

  $.post('/api/favourite', {
      userID: userId
    },
    function success(data) {
      console.log(data);
      if (data['response'] == 'favourite') {
        $favourite.removeClass('btn-primary').addClass('btn-danger');
        $favourite.text('Unfavourite');
      } else {
        $favourite.removeClass('btn-danger').addClass('btn-primary');
        $favourite.text('Favourite');
      }
    }
  )
}
