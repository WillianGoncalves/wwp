import M from 'materialize-css';

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
