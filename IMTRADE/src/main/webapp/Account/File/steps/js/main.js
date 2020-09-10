(function($) {

    var form = $("#signup-form");
    form.steps({
        headerTag: "h3",
        bodyTag: "fieldset",
        transitionEffect: "fade",
        labels: {
            previous : 'Précédent',
            next : 'suivant',
            finish : 'Terminer',
            current : ''
        },
        titleTemplate : '<h3 class="title">#title#</h3>',
        onFinished: function (event, currentIndex)
        {
            alert('Sumited');
        }
    });

    

    $('#daily_budget').parent().append('<ul id="newdaily_budget" class="select-list" name="daily_budget"></ul>');
    $('#daily_budget option').each(function(){
        $('#newdaily_budget').append('<li value="' + $(this).val() + '">'+$(this).text()+'</li>');
    });
    $('#daily_budget').remove();
    $('#newdaily_budget').attr('id', 'daily_budget');
    $('#daily_budget li').first().addClass('init');
    $("#daily_budget").on("click", ".init", function() {
        $(this).closest("#daily_budget").children('li:not(.init)').toggle();
    });
    
    var DailyOptions = $("#daily_budget").children('li:not(.init)');
    $("#daily_budget").on("click", "li:not(.init)", function() {
        DailyOptions.removeClass('selected');
        $(this).addClass('selected');
        $("#daily_budget").children('.init').html($(this).html());
        DailyOptions.toggle();
    });
    
    
    
    
})(jQuery);
