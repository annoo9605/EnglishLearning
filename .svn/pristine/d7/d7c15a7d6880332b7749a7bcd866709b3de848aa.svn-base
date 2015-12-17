jQuery(function($) {'use strict',

	//#main-slider
	$(function(){
		$('#main-slider.carousel').carousel({
			interval: 8000
		});
	});


	// accordian
	$('.accordion-toggle').on('click', function(){
		$(this).closest('.panel-group').children().each(function(){
		$(this).find('>.panel-heading').removeClass('active');
		 });

	 	$(this).closest('.panel-heading').toggleClass('active');
	});

	//Initiat WOW JS
	new WOW().init();

	// image-rearrange filter
	$(window).load(function(){'use strict';
		var $imageReArrangement_selectors = $('.image-rearrange-filter >li>a');
		var $imageReArrangement = $('.image-rearrange-items');
		$imageReArrangement.isotope({
			itemSelector : '.image-rearrange-item',
			layoutMode : 'fitRows'
		});
		
		$imageReArrangement_selectors.on('click', function(){
			$imageReArrangement_selectors.removeClass('active');
			$(this).addClass('active');
			var selector = $(this).attr('data-filter');
			$imageReArrangement.isotope({ filter: selector });
			return false;
		});
	});
	
	//Div Class reArrangement
	$(window).load(function(){'use strict';
	var $class_rearrangement_selectors = $('.class-rearrange-filter >li>a');
	var $class_rearrangement = $('.class-rearrange-items');
	$class_rearrangement.isotope({
		itemSelector : '.class-rearrange-item',
		layoutMode : 'fitRows'
	});
	
	$class_rearrangement_selectors.on('click', function(){
		$class_rearrangement_selectors.removeClass('active');
		$(this).addClass('active');
		var selector = $(this).attr('data-filter');
		$class_rearrangement.isotope({ filter: selector });
		return false;
	});
});
	
	
	
	// Contact form
	var form = $('#main-contact-form');
	form.submit(function(event){
		event.preventDefault();
		var form_status = $('<div class="form_status"></div>');
		$.ajax({
			url: $(this).attr('action'),

			beforeSend: function(){
				form.prepend( form_status.html('<p><i class="fa fa-spinner fa-spin"></i> Email is sending...</p>').fadeIn() );
			}
		}).done(function(data){
			form_status.html('<p class="text-success">' + data.message + '</p>').delay(3000).fadeOut();
		});
	});

	
	//goto top
	$('.gototop').click(function(event) {
		event.preventDefault();
		$('html, body').animate({
			scrollTop: $("body").offset().top
		}, 500);
	});	

	//Pretty Photo
	$("a[rel^='prettyPhoto']").prettyPhoto({
		social_tools: false
	});	
});