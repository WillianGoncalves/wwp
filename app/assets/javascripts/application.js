// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require materialize-css/dist/js/materialize.min
//= require nosleep.js/dist/NoSleep
//= require_tree .

var noSleep = new NoSleep();

$(document).ready(function() {
  $('select').material_select();

  $('.datepicker').pickadate({
    selectMonths: true,
    selectYears: 15,
    today: 'Today',
    clear: 'Clear',
    close: 'Ok',
    closeOnSelect: false
  });

  $('.timepicker').pickatime({
    default: 'now',
    fromnow: 0,
    twelvehour: false,
    donetext: 'OK',
    cleartext: 'Clear',
    canceltext: 'Cancel',
    autoclose: false,
    ampmclickable: true,
    aftershow: function(){}
  });

  $('button[data-enable-nosleep]').on('click', function(){
    noSleep.enable();
    $(this).fadeOut(1500);
  });

  $('button[data-disable-nosleep]').on('click', function(){
    noSleep.disable();
  });
});

// Initializes autocomplete for the "author" field, on songs form.
$('#song_author').ready(function() {
  var input = $('#song_author');
  var groupId = input.data('group_id');

  $.get("/groups/" + groupId + "/songs/authors", (data) => {
    let authors = {};

    for(let author of data) {
      authors[author] = null;
    }

    input.autocomplete({
      data: authors,
      limit: 5
    });
  });
});
