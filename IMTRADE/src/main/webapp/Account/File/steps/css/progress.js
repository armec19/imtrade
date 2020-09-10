
$(function () {
    let cnt = 0;

    setInterval(() => {
        cnt = (cnt + 1);

        if (cnt & 1) {
            $('#status1')
                    .text('Terminer')
                    .attr('class', 'status -success');
            $('#status2')
                    .text('Terminer')
                    .attr('class', 'status -success');
            $('#status3')
                    .text('Terminer')
                    .attr('class', 'status -success');
            cnt = 20;
        } else if (cnt & 0) {
            $('#status1')
                    .text('Parametrage')
                    .attr('class', 'status -pending');
            $('#status2')
                    .text('Contenu')
                    .attr('class', 'status -pending');
            $('#status3')
                    .text('Attachement')
                    .attr('class', 'status -pending');
        }
    }, 5000);
/*
    var pval = 0;
    var pcontent= 0;
    var ptotal = 0;
    var progressbar = $("#progressbar"),
            progressLabel = $(".progress-label");



    progressbar.progressbar({
        value: false,
        change: function () {
            progressLabel.text(pval + " % "+pcontent+" sur "+ptotal);
        },
        complete: function () {
            progressLabel.text("Complete!");
        }
    });
    progress();

    function progress() {

        progressbar.progressbar("value", parseInt(pval));
        var val = parseInt(pval);

        if (val < 100) {
            setTimeout(progress, 500);
        }
       
        
       
        

    }
*/
});