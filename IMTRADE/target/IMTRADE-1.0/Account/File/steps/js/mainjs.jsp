<script>
    (function ($) {

        var form = $("#signup-form");
        form.steps({
            headerTag: "h3",
            bodyTag: "fieldset",
            transitionEffect: "fade",
            labels: {
                previous: 'Précédent',
                next: 'suivant',
                finish: 'Terminer',
                current: ''
            },
            
            titleTemplate: '<h3 class="title">#title#</h3>',
            onFinished: function (event, currentIndex)
            {        
                $("#signup-form").load("steps/finish.jsp");   
            }
        });

        $('#country').parent().append('<ul id="newcountry" class="select-list" name="country"></ul>');
        $('#country option').each(function () {
            $('#newcountry').append('<li value="' + $(this).val() + '">' + $(this).text() + '</li>');
        });
        $('#country').remove();
        $('#newcountry').attr('id', 'country');
        $('#country li').first().addClass('init');
        $("#country").on("click", ".init", function () {
            $(this).closest("#country").children('li:not(.init)').toggle();
        });

        var allOptions = $("#country").children('li:not(.init)');
        $("#country").on("click", "li:not(.init)", function () {
            allOptions.removeClass('selected');
            $(this).addClass('selected');
            $("#country").children('.init').html($(this).html());
            allOptions.toggle();
        });
    <%  String tab[] = {"projet", "fournisseur", "nature", "type", "designation"};
        for (int idx = 0; idx < tab.length; idx++) {
            String elem = tab[idx];
    %>
        $('#<%=elem%>').parent().append('<ul id="new<%=elem%>" class="select-list" name="<%=elem%>" style="background:white;"></ul>');
        $('#<%=elem%> option').each(function () {
            $('#new<%=elem%>').append('<li value="' + $(this).val() + '">' + $(this).text() + '</li>');
        });
        $('#<%=elem%>').remove();
        $('#new<%=elem%>').attr('id', '<%=elem%>');
        $('#<%=elem%> li').first().addClass('init');
        $("#<%=elem%>").on("click", ".init", function () {
            $(this).closest("#<%=elem%>").children('li:not(.init)').toggle();
        });

        var DailyOptions = $("#<%=elem%>").children('li:not(.init)');
        $("#<%=elem%>").on("click", "li:not(.init)", function () {
            DailyOptions.removeClass('selected');
            $(this).addClass('selected');
            $("#<%=elem%>").children('.init').html($(this).html());
            DailyOptions.toggle();

        });

    <%

        }
    %>


    })(jQuery);

</script>