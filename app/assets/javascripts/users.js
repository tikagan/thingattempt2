$(document).on('turbolinks:load', function() {

  $("#email").emailautocomplete({
    domains: ["fintros.com"] //additional domains
  });

  function clearFields() {
    $('#full_name').val("");
    $('#company_name').val("");
  };

  //this is the internal rails Clearbit call for user info
  $("#email").focusout(function() {
    $('.query_text').toggleClass('hide');
    $.ajax({
      method: 'GET',
      dataType: 'JSON',
      url: '/cbit/' + $('#email').val()

      }).done(function(data){
        clearFields();
        $('#full_name').val(data.person.name.fullName);
        $('.hiddenfields').removeClass( 'hide' );
        $('.query_text').toggleClass('hide');
        $('#company_name').val(data.company.legalName);
      }).fail(function(){
        clearFields();
        console.log('Person not found!');
        $('.hiddenfields').removeClass( 'hide' );
        $('.query_text').toggleClass('hide');
      });
  });

  //this prevents the user clicking enter on the initial email boxx to submit
  $('#email').keypress(function(event) {
    if (event.keyCode == 13) {
      event.preventDefault();
      $('#email').blur()
    };
  });

  //This function uses an AJAX call to dynamically scrape meetup's user data, and append it to the page
  $("#scrape_form").submit(function(e) {
    e.preventDefault();
    $('.loading_icon').toggleClass('hide');

    $.ajax({
      method: $(this).attr('method'),
      url: $(this).attr('action'),
      dataType: 'JSON',

      }).done(function(data){
        $('.loading_icon').toggleClass('hide');
        var names = [];

        for (var i = 0; i < data.length; i++) {
            names.push($('<li>', { text: data[i] }));
        };

        $('#userlist').append(names);

      }).fail(function(){
        console.log('ajax fail');
        $('.loading_icon').toggleClass('hide');
      });
  });

});