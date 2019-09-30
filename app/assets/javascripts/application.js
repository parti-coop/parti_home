//= require rails-ujs
//= require jquery3
//= require popper
//= require bootstrap-sprockets
//= require ResizeSensor
//= require jquery.sticky-sidebar
//= require aos

$(function() {
  AOS.init();

  $('.js-sticky-sidebar').stickySidebar({
    topSpacing: 20,
    bottomSpacing: 20,
    minWidth: 769,
  });
})
