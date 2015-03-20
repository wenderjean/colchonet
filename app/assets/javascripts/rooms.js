$(function() {
	// var $review = $('.review');

	// $review.on('ajax:beforeSend', function() {
	// 	$(this).find('input').attr('disabled', true);
	// });

	// $review.on('ajax:error', function() {
	// 	replaceButton(this, 'icon-remove', '#B94A48');
	// });

	// $review.on('ajax:success', function() {
	// 	replaceButton(this, 'icon-ok', '#468847');
	// });

	highlightStars($('.review input:checked + label'));

	var $stars = $('.review input:enabled ~ label');
	
	$stars.on('mouseenter', function() {
	  	highlightStars($(this));
	});

	$stars.on('mouseleave', function() {
	  	highlightStars($('.review input:checked + label'));
	});

	$('.review input').on('change', function() {
	    $stars.off('mouseenter').off('mouseleave').off('click');
	    $(this).parent('form').submit();
	});

	function replaceButton(container, icon_class, color) {
		var icon = $('<i/>').addClass(icon_class).css('color', color);
		$(container).find('input:submit').replaceWith(icon);
	}

	function highlightStars(elem) {
	  elem.parent().children('label').removeClass('toggled');
	  elem.addClass('toggled').prevAll('label').addClass('toggled');
	}
});