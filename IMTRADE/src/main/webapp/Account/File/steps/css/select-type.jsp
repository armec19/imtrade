<script>
    console.clear();

    var el = {};


    <%
    for (int i = 0; i < 10; i++) {
    %>
    $('.placeholder<%=i%>').on('click', function (ev) {
        $('.placeholder<%=i%>').css('opacity', '0');
        $('.list__ul<%=i%>').toggle();
    });

    $('.list__ul<%=i%> a').on('click', function (ev) {
        ev.preventDefault();
        var index = $(this).parent().index();

        $('.placeholder<%=i%>').text($(this).text()).css('opacity', '1');

        console.log($('.list__ul<%=i%>').find('li').eq(index).html());

        $('.list__ul<%=i%>').find('li').eq(index).prependTo('.list__ul<%=i%>');
        $('.list__ul<%=i%>').toggle();

    });


    $('select').on('change', function (e) {

        // Set text on placeholder hidden element
        $('.placeholder<%=i%>').text(this.value);

        // Animate select width as placeholder
        $(this).animate({width: $('.placeholder<%=i%>').width() + 'px'});

    });

    <%
    }
    %>
</script>