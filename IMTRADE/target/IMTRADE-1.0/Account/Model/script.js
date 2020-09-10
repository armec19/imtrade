var options = {
    valueNames: ['material', 'quantity', 'price']
}
, documentTable = new List('mdl-table', options)
        ;


$($('th.sort')[0]).trigger('click', function () {
    console.log('clicked');
});

$('input.search').on('keyup', function (e) {
    if (e.keyCode === 27) {
        $(e.currentTarget).val('');
        documentTable.search('');
    }
});


$('.search-toggle').click(function () {
    if ($('.hiddensearch').css('display') == 'none') {
        $('.hiddencolumn').slideUp(function () {
            $('.hiddenfilter').slideUp(function () {
                $('.hiddenadd').slideUp(function () {
                    $('.hiddensearch').slideDown();
                });
            });
        });
    } else
        $('.hiddensearch').slideUp();
});
$('.column-toggle').click(function () {
    if ($('.hiddencolumn').css('display') == 'none') {
        $('.hiddensearch').slideUp(function () {
            $('.hiddenadd').slideUp(function () {
                $('.hiddenfilter').slideUp(function () {
                    $('.hiddencolumn').slideDown();
                });
            });
        });
    } else
        $('.hiddencolumn').slideUp();
});

$('.filter-toggle').click(function () {
    if ($('.hiddenfilter').css('display') == 'none') {
        $('.hiddensearch').slideUp(function () {

            $('.hiddenadd').slideUp(function () {
                $('.hiddencolumn').slideUp(function () {
                    $('.hiddenfilter').slideDown();
                });
            });
        });
    } else
        $('.hiddenfilter').slideUp();
});

$('.add-toggle').click(function () {
    if ($('.hiddenadd').css('display') == 'none') {
        $('.hiddensearch').slideUp(function () {
            $('.hiddenfilter').slideUp(function () {
                $('.hiddencolumn').slideUp(function () {
                    $('.hiddenadd').slideDown();
                });
            });
        });
    } else
        $('.hiddenadd').slideUp();
});