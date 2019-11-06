$(document).ready(function () {

    var clickcount = 0;

    $('.root').waypoint(function (direction) {
        if (direction == "down") {
            $('nav').addClass('backcolor');
        } else {
            $('nav').removeClass('backcolor');
        }
    }, {
        offset: '35px;'
    });


    //    Animation On scroll

    $('.js-animate-1').waypoint(function () {
        $('.js-animate-1').addClass('animated fadeInUp');
    }, {
        offset: '85%'
    });


    $('.js-animate-2').waypoint(function () {
        $('.js-animate-2').addClass('animated fadeInUp');
    }, {
        offset: '85%'
    });


    $('.js-animate-3').waypoint(function () {
        $('.js-animate-3').addClass('animated fadeInUp');
    }, {
        offset: '85%'
    });


    $('.js-animate-4').waypoint(function () {
        $('.js-animate-4').addClass('animated fadeInUp');
    }, {
        offset: '85%'
    });


    $('.js-animate-dn').waypoint(function () {
        $('.js-animate-dn').addClass('animated fadeInDown');
    }, {
        offset: '85%'
    });



    // Mobile Navigation

    $('.hamburger').click(function () {

        clickcount += 1;

        $('.js-disp').toggleClass('disp');

        if (clickcount % 2 !== 0) {
            $('nav').addClass('backcolour');
        } else {
            $('nav').removeClass('backcolour');
        }
    });


//    $('.notice').click(function (e) {
//        $('html, body').animate({
//            scrollTop: $('#notice').offset().top - 100
//        }, 5000);
//    });

});

