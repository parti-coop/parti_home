//= require rails-ujs
//= require jquery3
//= require popper
//= require bootstrap-sprockets
//= require ResizeSensor
//= require jquery.sticky-sidebar
//= require aos

var __parti_apply = function($base, query, callback) {
  $.each($base.find(query).addBack(query), function(i, elm){
    callback(elm);
  });
}

var __parti_prepare = function($base, force) {
  if(!force && $base.data('parti-prepare-arel') == 'completed') {
    return;
  }

  __parti_apply($base, '.js-sticky-sidebar', function(elm) {
    $(elm).stickySidebar({
      topSpacing: 20,
      bottomSpacing: 20,
      minWidth: 769,
    });
  });

  $base.data('parti-prepare-arel', 'completed');
}

$(function() {
  __parti_prepare($('body'));

  AOS.init();
  $('.js-toast').toast({
    delay: 300000,
  });
  $('.js-toast').toast('show');
})

var parti_partial$ = function($partial, force) {
  __parti_prepare($partial, force);

  return $partial;
}
