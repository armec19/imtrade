<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.List"%>
<%    session.setAttribute("New", "true");%>
<jsp:include page="/Content" />
<%
    HashMap<String, String> data = (HashMap<String, String>) session.getAttribute("hashMap");
    List<String[]> objet = (ArrayList<String[]>) session.getAttribute("ListObject");

    String num = "";
    String docname = "demande dachat";
    String date = "--/--/----";
    if (!"".equals(data.get("dated")) || !"".equals(data.get("num"))) {
        num = data.get("num") + "/RST/";
        if (data.get("dated").length() > 8) {
            date = data.get("dated");
            num = num + data.get("dated").substring(8);
        }
    }
    double timbre = 0;

    String entete_nom = "EURL IMTRADE";
    String entete_capital = "Au capital de : 10 100 000 DA";
    String entete_adr = "N°02 Rue Aloui Hafnaoui Biskra,ALGERIE";
    String entete_rc = "RC N : 13B0243192-07/02 du: 29/03/2016";
    String entete_nif = "N.I.F : 001307024319237";
    String entete_nis = "N.I.S : 001307010003181";
    String entete_art = "A.r.t : 07017105763";
    String entete_rib = "RIB : 029-006-072-260-010-421-58";
    String entete_banque = "Banque TRUST Agence : BISKRA";


%>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <title>Revue en PDF</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta name="description" content="">
        <meta name="author" content="">

        <!-- Bootstrap -->
        <link href="PDF/examples/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="steps/fonts/material-icon/css/material-design-iconic-font.min.css">
        <link rel="stylesheet" href="steps/css/style.css">

        <link href="PDF/examples/css/editor.css" rel="stylesheet">
        <link href="steps/css/select.css" rel="stylesheet">
    </head>

    <body>
        <style>
            .h33:hover{
                color: #6dbdfe;
            }
        </style>
        <div class="row-fluid" style="">
            <div class="span6" style="float: right; height: 200px;width: 500px;" >
                <div id="preview-pane" style="height: 600px;position:relative; z-index:999"></div>
            </div>
            <div id="content_js" style="display:none;" >
                var doc = new jsPDF()

                doc.setProperties({
                title: 'Document IMTRADE',
                subject: 'Projet',
                author: 'USER',
                keywords: '--/RST/--',
                creator: 'EURL IMTRADE'
                });

                var totalPagesExp = '{total_pages_count_string}'

                //DA_ENGINERING
                //DA_ITNE
                //DA_DS
                //DA_VENTE

                var options = {   pagesplit: true,'width': 550}
                var imgData = document.createElement("img");
                imgData.src = "ressources/logo_engineering.jpg";



                doc.addImage(imgData, 8, 8, 80,27);
                doc.line(90, 8, 90,35);
                var imgDataqr = document.createElement("img");
                imgDataqr.src = "../code/DA_1658492165.png";

                doc.addImage(imgDataqr,180,doc.internal.pageSize.height - 30, 20, 20);

                doc.setFontSize(20);doc.setFontStyle('bold');doc.text('ORDER DE MISSION',120,20,'left');

                doc.setFontSize(18);doc.setFontStyle('bold');doc.text('N°... Du ..-..-....',120,30,'left');



                doc.autoTable({
                bodyStyles: {
                fillColor: [255, 255, 255],
                },
                alternateRowStyles: {
                fillColor: [255, 255, 255],
                },


                columnStyles: {
                fillColor: [255, 255, 255],textColor: [30],fontStyle: 'normal',halign: 'left',
                0: {cellWidth: 135},
                1: {cellWidth: 50},
                },


                footStyles: {fillColor: [255, 255, 255],textColor: [30],halign: 'left',fontSize:15,rowHeight:28},
                foot: [['Client: '],
                ['Client Final: '],
                ['Bon de commande: '],
                ['Date du bon de commmande: '],
                ['Délai: '],
                ['Désignation: '],
                ['Montant TTC: '],
                ],
                margin: { top: 56,bottom: 35,left:8,right:45,width: 100},
                })




            </div>

            <div id="editor" class="bypass" ></div>

            <div class="controls" style="display:none;">
                <div class="pull-right">
                    <!--<a href="#" class="btn btn-primary">Download Your Code</a>-->
                    <a href="#" class="btn btn-primary download-pdf">Download PDF</a>
                </div>

                <label class="checkbox">
                    <input type="checkbox" id="auto-refresh" checked="checked"> Auto refresh on changes?
                </label>

                <div class="alert hide">
                    Auto refresh disabled for this
                </div>

            </div>

        </div>
        <div class="clerfix"></div>	

        <script   src="PDF/examples/js/jquery/jquery-1.7.1.min.js"></script>

        <script type="text/javascript">
            $(document).ready(function () {
                if (jsPDF && jsPDF.version) {
                    $('#dversion').text('Version ' + jsPDF.version);
                }
            });
        </script>

        <!-- Code editor -->
        <script src="steps/css/chiffreenlettre.js" type="text/javascript" charset="utf-8"></script>
        <script src="PDF/examples/js/ace.js" type="text/javascript" charset="utf-8"></script>

        <!-- Scripts in development mode -->
        <script type="text/javascript" src="PDF/dist/jspdf.debug.js"></script>		
        <script src="PDF/libs/faker.min.js"></script>
        <script src="PDF/libs/jspdf.plugin.autotable.js"></script>
        <script type="text/javascript" src="PDF/examples/js/pdfobject.min.js"></script>
        <script type="text/javascript" src="PDF/examples/js/editor.js"></script>
           
        <script src="https://cdnjs.cloudflare.com/ajax/libs/react/15.4.2/react.js" charset="utf-8"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/react/15.4.2/react-dom.js" charset="utf-8"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/babel-standalone/6.21.1/babel.min.js" charset="utf-8"></script>


    </body>
</html>
