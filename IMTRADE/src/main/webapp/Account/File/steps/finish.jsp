<%@page import="Classes.FileUpload"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>

<!--<h3 id="signup-form-h-0" tabindex="-1" class="title current">Traitement...</h3>-->
<fieldset id="signup-form-p-0" role="tabpanel" aria-labelledby="signup-form-h-0" class="body current" aria-hidden="false">     

    <div style="width: 100%;padding: 0px;">
        <div class="col-lg-12" style="color:#368;"><h3 class="h33">Parametrage</h3></div>
        <div class="col-lg-12"><div id="status1" class="status -pending"></div></div>
        <div class="col-lg-12" style="color:#368;"><h3 class="h33">Contenu</h3></div>
        <div class="col-lg-12"><div id="status2" class="status -pending"></div></div>

        <!--        <div class="col-lg-12" style="color:#368;"><h3 class="h33">Les attachements de creation</h3></div>
                <div class="col-lg-12"><div id="status3" class="status -pending"></div></div>
                <div class="col-lg-12" style="color:#368;"><h3 class="h33">Les attachements de confirmation</h3></div>
                <div class="col-lg-12"><div id="status4" class="status -pending"></div></div>-->


        <%

            List<String[]> ListFile_av = (ArrayList<String[]>) session.getAttribute("ListFile_av");

            if (ListFile_av.size() > 0) {

        %>
        <div class="col-lg-12" style="color:#368;"><h3 class="h33">Les attachements de creation</h3></div>
        <div class="col-lg-12"><div id="status3" class="status -pending"></div></div>
            <%            for (int idx = 0; idx < ListFile_av.size(); idx++) {
            %>

        <div class="col-lg-12" style="color:#368;">
            <h5 id="filename<%= idx%>">-&#160;<%= ListFile_av.get(idx)[1]%>.pdf</h5>
            <div id="progressbar<%= idx%>">
                <div class="progress-label progress-label<%= idx%>"></div>    
            </div>

        </div>

        <% }
            }
        %>

        <%
            List<String[]> ListFile_ap = (ArrayList<String[]>) session.getAttribute("ListFile_ap");

            if (ListFile_ap.size() > 0) {

        %>
        <div class="col-lg-12" style="color:#368;"><h3 class="h33">Les attachements de confirmation</h3></div>
        <div class="col-lg-12"><div id="status3" class="status -pending"></div></div>
            <%            for (int idx = 0; idx < ListFile_ap.size(); idx++) {
            %>

        <div class="col-lg-12" style="color:#368;">
            <h5 id="filename<%= idx%>">-&#160;<%= ListFile_ap.get(idx)[1]%>.pdf</h5>
            <div id="progressbar<%= idx%>">
                <div class="progress-label progress-label<%= idx%>"></div>    
            </div>
        </div>

        <% }
            }
        %>


    </div>
    <%@page import="java.util.ArrayList"%>
    <%@page import="Classes.FileUpload"%>
    <%@page import="java.util.List"%>
    <link rel="stylesheet" href="http://code.jquery.com/ui/1.10.3/themes/smoothness/jquery-ui.css" />
    <script src='https://cdnjs.cloudflare.com/ajax/libs/jqueryui/1.11.4/jquery-ui.min.js'></script>
    <script src='https://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js'></script>
    <script src="http://code.jquery.com/jquery-1.9.1.js"></script>
    <script src="http://code.jquery.com/ui/1.10.3/jquery-ui.js"></script>
    <script>

        $(function () {
            let cnt = 0;

            setInterval(() => {
                cnt = (cnt + 1);

                if (cnt & 1) {
                    $('#status1')
                            .text('Parametrage est termin�')
                            .attr('class', 'status -success');
                    $('#status2')
                            .text('Contenu est termin�')
                            .attr('class', 'status -success');
                    $('#status3')
                            .text('Les attachements de creation sont mises en ligne')
                            .attr('class', 'status -success');
                    $('#status4')
                            .text('Les attachements de confirmation sont mises en ligne')
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
                            .text('Les attachements de creation')
                            .attr('class', 'status -pending');
                    $('#status4')
                            .text('Les attachements de confirmation')
                            .attr('class', 'status -pending');
                }
            }, 2000);

        });

    </script>

    <%  List<FileUpload> FileContent_av = (ArrayList<FileUpload>) session.getAttribute("FileContent_av");
        for (int idx = 0; idx < FileContent_av.size(); idx++) {

            FileUpload elem = FileContent_av.get(idx);
    %>

    <style>
        .ui-progressbar {
            position: relative;
            height: 15px;
            position: relative;
            width: 100%;
            height: 10px;
            border-radius: 0px;
            border: solid 1px #93d2ff;
            height:20px;
            -webkit-border-radius: 3px;
            -moz-border-radius: 3px;
            border-radius: 3px;
        }
        .progress-label {
            position: absolute;
            color:#368;
            font-size: 10px;
            left: 1%;
            font-weight: bold;
            text-shadow: 1px 1px 0 #fff;
        }
        .ui-progressbar-value {
            padding-bottom: 20px;
            width: 0px;
            background-color: #09f;
            height:20px;
            transition: width 2s;
            -webkit-border-radius: 3px;
            -moz-border-radius: 3px;
            border-radius: 3px;
            background-image: -webkit-linear-gradient(left, #09f 95%, #fff 105%, #fff 105%);
        }
    </style>

    <script>

        $(function () {
            var pval = 0;
            var pcontent = 0;
            var ptotal = 0;
            var pfile = "";
            var res = "%%%%%%%".split("%", 5);
            var i = parseInt(res[4]);
            var progressbar = $("#progressbar" + res[4]), progressLabel = $(".progress-label" + res[4]);
            var nouveau = false;
            var sizelist = parseInt(<%= FileContent_av.size()%>);

            progress();

            function progress() {


                $.ajax({
                    url: '/IMTRADE/Ajouterdocument',
                    contentType: 'application/json; charset=utf-8',
                    method: "GET",
                    data: {
                        pval: pval
                    },
                    success: function (response) {
                        //pval = response;
                        res = response.split("%", 5);
                        pval = parseInt(res[0]);
                        ptotal = res[1];
                        pcontent = res[2];
                        i = parseInt(res[4]);

                        progressbar.progressbar({
                            value: false,
                            change: function () {
                                progressLabel.text(pval + " % " + pcontent + " sur " + ptotal);
                            },
                            complete: function () {
                                progressLabel.text("Complete!");
                                progressbar = $("#progressbar" + i), progressLabel = $(".progress-label" + i);
                            }
                        });



                        $("#filename" + i).text(res[3]);


                        //alert(response);
                    },
                    error: function (errorThrown) {
                        //alert("not success :" + errorThrown);
                    }
                });

                progressbar.progressbar("value", parseInt(pval));
                var val = parseInt(pval);

                if (val < 100 && i < sizelist) {
                    setTimeout(progress, 500);
                }

            }

        });

    </script>

    <% }%>






    <%  List<FileUpload> FileContent_ap = (ArrayList<FileUpload>) session.getAttribute("FileContent_ap");
        for (int idx = 0; idx < FileContent_ap.size(); idx++) {

            FileUpload elem = FileContent_ap.get(idx);
    %>

    <style>
        .ui-progressbar {
            position: relative;
            height: 15px;
            position: relative;
            width: 100%;
            height: 10px;
            border-radius: 0px;
            border: solid 1px #93d2ff;
            height:20px;
            -webkit-border-radius: 3px;
            -moz-border-radius: 3px;
            border-radius: 3px;
        }
        .progress-label {
            position: absolute;
            color:#368;
            font-size: 10px;
            left: 1%;
            font-weight: bold;
            text-shadow: 1px 1px 0 #fff;
        }
        .ui-progressbar-value {
            padding-bottom: 20px;
            width: 0px;
            background-color: #09f;
            height:20px;
            transition: width 2s;
            -webkit-border-radius: 3px;
            -moz-border-radius: 3px;
            border-radius: 3px;
            background-image: -webkit-linear-gradient(left, #09f 95%, #fff 105%, #fff 105%);
        }
    </style>

    <script>

        $(function () {
            var pval = 0;
            var pcontent = 0;
            var ptotal = 0;
            var pfile = "";
            var res = "%%%%%%%".split("%", 5);
            var i = parseInt(res[4]);
            var progressbar = $("#progressbar" + res[4]), progressLabel = $(".progress-label" + res[4]);
            var nouveau = false;
            var sizelist = parseInt(<%= FileContent_ap.size()%>);

            progress();

            function progress() {


                $.ajax({
                    url: '/IMTRADE/Ajouterdocument',
                    contentType: 'application/json; charset=utf-8',
                    method: "GET",
                    data: {
                        pval: pval
                    },
                    success: function (response) {

                        res = response.split("%", 3);
                        pval = parseInt(res[0]);
                        ptotal = res[1];
                        pcontent = res[2];
                        i = parseInt(res[4]);

                        progressbar.progressbar({
                            value: false,
                            change: function () {
                                progressLabel.text(pval + " % " + pcontent + " sur " + ptotal);
                            },
                            complete: function () {
                                progressLabel.text("Complete!");
                                progressbar = $("#progressbar" + i), progressLabel = $(".progress-label" + i);
                            }
                        });

                        $("#filename" + i).text(res[3]);
                        //alert(response);
                    },
                    error: function (errorThrown) {
                        //alert("not success :" + errorThrown);
                    }
                });

                progressbar.progressbar("value", parseInt(pval));
                var val = parseInt(pval);

                if (val < 100 && i < sizelist) {
                    setTimeout(progress, 500);
                }

            }

        });

    </script>

    <% }%>
</fieldset>



<!--<script>
    $(document).ready(function () {
        $.ajax({
            url: '/IManage-war/Ajouterdocument',
            data: {lastpart: "creation"},
            contentType: 'application/json; charset=utf-8',
            success: function (response) {
                //alert("creation successed");
            },
            error: function (errorThrown) {
                alert("Not success :" + errorThrown);
            }
        });
        $('.actions').css("display", "none");
    });
</script>-->




