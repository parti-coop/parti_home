//= require rails-ujs
//= require jquery3
//= require popper
//= require bootstrap-sprockets
//= require ResizeSensor
//= require jquery.sticky-sidebar
//= require aos
//= require kakao

Kakao.init('497c9a46f0645fa96fe0d31c607ba74a');

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
  $('.js-toast').toast('show');

  // share
  $.each($('.js-share-kakao'), function(index, elm) {
    var $elm = $(elm);

    var url = $elm.data('share-url');
    var image_url = $elm.data('share-image');
    var image_width = $elm.data('share-image-width');
    var image_height = $elm.data('share-image-height');

    var title = $elm.data('share-title');
    var description = $elm.data('share-description');
    Kakao.Link.createDefaultButton({
      container: elm,
      objectType: 'feed',
      content: {
        title: title,
        description: description,
        imageUrl: image_url,
        link: {
          mobileWebUrl: url,
          webUrl: url
        }
      }
    });
  });
})

var parti_partial$ = function($partial, force) {
  __parti_prepare($partial, force);

  return $partial;
}
