import NoSleep from 'nosleep.js';

const noSleep = new NoSleep();

$(document).ready(() => {
  $('button[data-enable-nosleep]').on('click', () => {
    noSleep.enable();
    $(this).fadeOut(1500);
  });

  $('button[data-disable-nosleep]').on('click', () => {
    noSleep.disable();
  });
});
