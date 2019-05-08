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
//= require materialize-css/dist/js/materialize
//= require nosleep.js/dist/NoSleep
//= require_tree .

var noSleep = new NoSleep();

const initializeSidenavs = () => {
  const sidenavs = document.querySelectorAll('.sidenav')
  M.Sidenav.init(sidenavs)
}

const initializeSelects = () => {
  const selects = document.querySelectorAll('select')
  M.FormSelect.init(selects)
}

const initializeDatepickers = () => {
  // TODO: install https://github.com/fnando/i18n-js to use i18n
  // For datepicker options, see: https://materializecss.com/pickers.html
  const datepickers = document.querySelectorAll('.datepicker')
  M.Datepicker.init(datepickers)
}

const initializeTimepickers = () => {
  // TODO: install https://github.com/fnando/i18n-js to use i18n
  // For timepicker options, see: https://materializecss.com/pickers.html
  const timepickers = document.querySelectorAll('.timepicker')
  M.Timepicker.init(timepickers)
}

const initializeTabs = () => {
  const tabs = document.querySelectorAll('.tabs')
  M.Tabs.init(tabs)
}

const initializeDropdowns = () => {
  const dropdowns = document.querySelectorAll('.dropdown-trigger')
  M.Dropdown.init(dropdowns)
}

document.addEventListener('DOMContentLoaded', () => {
  initializeDatepickers()
  initializeDropdowns()
  initializeSelects()
  initializeSidenavs()
  initializeTabs()
  initializeTimepickers()
});

$(document).ready(() => {
  $('button[data-enable-nosleep]').on('click', () => {
    noSleep.enable();
    $(this).fadeOut(1500);
  });

  $('button[data-disable-nosleep]').on('click', () => {
    noSleep.disable();
  });
});

// Initializes autocomplete for the "author" field, on songs form.
$('#song_author').ready(function() {
  var input = $('#song_author');
  var groupId = input.data('group_id');

  if (groupId) {
    $.get("/groups/" + groupId + "/songs/authors", function(data) {
      var authors = {};

      data.forEach(function(author) {
        authors[author] = null;
      });

      input.autocomplete({
        data: authors,
        limit: 5
      });
    });
  }
});
