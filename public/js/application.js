$(document).ready(function () {
  // send an HTTP DELETE request for the sign-out link

  $('a#sign-out').on('click', function (e) {
    e.preventDefault();
    var request = $.ajax({ url: $(this).attr('href'), type: 'delete' });
    request.done(function () { window.location = '/'; });
  });

  $('#fun-btn').on('click', function(e){
  // $('#fun-btn').hover(function(e){
  	e.preventDefault();

  	var random = Math.floor(Math.random() * 6);
  	if (random === 0) $('#fun-btn').animate({'right': '-=50px'}, 'fast');
  	if (random === 1) $('#fun-btn').animate({'right': '+=50px'}, 'fast');
  	if (random === 2) $('#fun-btn').fadeOut('slow', function(){});
  	if (random === 3) $('#fun-btn button').animate({'height': '20px', 'width': '20px'});
  	if (random === 4) $('#fun-btn button').animate({'height': '50px', 'width': '50px'});
  	if (random === 5) $('#fun-btn button').animate({'height': '60px', 'width': '20px'});
  });

  $('img').on('click', function(e){
    e.preventDefault();
    $('#omg').show();
  });

});
