function favourite(userId) {
    $.post(
        '/api/favourite',
        {
            userID: userId
        },
        function(data) {
            console.log(data);
            if(data['response'] == 'favourite') {
                $('#favourite').removeClass('btn-primary').addClass('btn-danger');
                $("#favourite").text('Unfavourite');
            }
            else{
                $('#favourite').removeClass('btn-danger').addClass('btn-primary');
                $("#favourite").text('Favourite');
            }
        }
    )
}
