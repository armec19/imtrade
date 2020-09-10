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

    out.print("<h3 class='h33' style='text-align:center'>Revue en PDF<h3>");
    String num = "";
    String docname= "Bon d entrée";//
    String date = "--/--/----";
    if (!"".equals(data.get("dated")) || !"".equals(data.get("num"))) {
        num = data.get("num") + "/DR/";
        if (data.get("dated").length() > 8) {
            date = data.get("dated");
            num = num + data.get("dated").substring(8);
        }
    }
    double timbre = 0;
    String conum="condition";
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


        <!-- Editor CSS -->

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
            <div class="span6" style="float: right; height: 550px;width: 100%;" >
                <div id="preview-pane" style="height: 100%;position:relative; z-index:999"></div>
            </div>
            <div id="content_js" style="display:none;">

                var doc = new jsPDF()
                
                doc.setProperties({
                    title: 'Document IMTRADE',
                    subject: '<%= docname%>',
                    author: 'USER',
                    keywords: '<%= num%>',
                    creator: 'EURL IMTRADE'
                });
                
                var totalPagesExp = '{total_pages_count_string}'
                var heights = 0;
                //DA_ENGINERING
                //DA_ITNE
                //DA_DS
                //DA_VENTE
                
                var imgData = document.createElement("img");
                imgData.src = "ressources/ds.jpg";
               
                var options = {   pagesplit: true,'width': 550}

                doc.addImage(imgData, -7, -5, 226, 310);
                
                var imgDataqr = document.createElement("img");
                imgDataqr.src = "../code/DA_1658492165.png";

                doc.addImage(imgData, -7, -5, 226, 310);

                doc.autoTable({
                
                bodyStyles: {
                    fillColor: [222, 222, 222],
                },
                alternateRowStyles: {
                    fillColor: [222, 222, 222],
                },
                
                /*tableLineColor: [231, 76, 60],
                tableLineWidth: 1,*/
                styles: {
                lineColor: [255,255,255],
                lineWidth: 1,
                fillColor: [222, 222, 222],
                },
                head: [['N°','Objet', 'Désignation','Condition','Qté','U.M']],

                bodyStyles: {4:{halign: 'right'}},

                headStyles: {
                //red
                fillColor: [249, 66, 66]
                //green
                //headStyles: {fillColor: [27, 208, 141]},
                //blue
                //headStyles: {halign: 'center',fillColor: [51, 122, 183]},
                },

                columnStyles: {
                0: {halign: 'left',cellWidth: 12},
                1: {halign: 'left',cellWidth: 25},
                2: {halign: 'left',cellWidth: 92},
                3: {halign: 'right',cellWidth: 25},
                4: {halign: 'left',cellWidth: 25},
                5: {halign: 'right',cellWidth: 20},
                },
                
                body: [
                ['','','','',''],
                ['','','','',''],
                <% for (int idx = 0; idx < objet.size(); idx++) {
                        String[] elem = objet.get(idx);
                %>
                ['<%=idx + 1%>','<%=elem[0]%>', '<%=elem[1]%>','<%=elem[2]%>', '<%=elem[3]%>','<%=elem[4]%>'],
                <%
                    }
                %>
                ],

                didDrawPage: function (data) {
                heights= data.table.body.length+1;
                var str = 'Page ' + doc.internal.getNumberOfPages()
                if (typeof doc.putTotalPages === 'function') {
                str = str + ' of ' + totalPagesExp
                }
                doc.setFontSize(7);

                doc.addImage(imgDataqr,6,doc.internal.pageSize.height - 19, 13, 13);
                var pageSize = doc.internal.pageSize
                var pageHeight = pageSize.height ? pageSize.height : pageSize.getHeight()
                doc.text(str, data.settings.margin.left+12, pageHeight-8, 'left')
                str = "www.imtrade-dz.com";  
                doc.setFontSize(7);
                doc.text(str, data.settings.margin.left+12, pageHeight - 13, 'left');
                str = "Tél/Fax: 033 53 47 78  / Email: commercial@imtrade-dz.com";  
                doc.setFontSize(7);
                doc.text(str, data.settings.margin.left+12, pageHeight - 15.5);
                header(doc)
                },
                margin: { top: 66,bottom: 30,left:7,right:5,width: 100},
                })


                if (typeof doc.putTotalPages === 'function') {
                doc.putTotalPages(totalPagesExp)
                }

                function footer(doc, pageNumber, totalPages){

                var str = "Page " + pageNumber + " de " + totalPages;  
                doc.setFontSize(7);
                doc.text(str, margins.left, doc.internal.pageSize.height-12);
                str = "www.imtrade-dz.com";  
                doc.setFontSize(7);
                doc.text(str, margins.left, doc.internal.pageSize.height - 15,'left');
                str = "Tél/Fax: 033 53 47 78  / Email: commercial@imtrade-dz.com";  
                doc.setFontSize(7);
                doc.text(str, margins.left, doc.internal.pageSize.height - 18,'left');
                };


                function header(doc)
                {

                doc.setFontSize(7);doc.setFontStyle('normal');doc.text('<%=entete_nom%>',202, 7,'right');
                doc.text('<%=entete_capital%>', 202,9.5,'right');
                doc.text('<%=entete_adr%>', 202, 12,'right');
                doc.text('<%=entete_rc%>', 202, 14.5,'right');
                doc.text('<%=entete_nif%>',202, 17,'right');
                doc.text('<%=entete_nis%>',202, 19.5,'right');
                doc.text('<%=entete_art%>',202, 22,'right');
                doc.text('<%=entete_rib%>', 202,24.5,'right');
                doc.text('<%=entete_banque%>',202, 27,'right');

                doc.setFontSize(11);doc.setFontStyle('bold');doc.setTextColor(255,255,255);doc.text('<%= docname%> N°: <%= num%>',8, 35,'left');
                doc.setFontSize(10);doc.setFontStyle('bold');doc.setTextColor(255,255,255);doc.text('<%= date%>',9,40,'left');
                doc.setFontSize(9);doc.setFontStyle('normal');doc.setTextColor(40);
                var splitTitle = doc.splitTextToSize('<%= data.get("destinateur")%>\n<%= "Adresse: "+data.get("adr")%> \n<%= "Registre de commerce: "+data.get("registre")%>\n<%= "Agrement: "+data.get("agrement")%>\n<%= "N.I.F: "+data.get("nif")%>\n<%= "A.I: "+data.get("articlei")%> \n<%= "Email: "+data.get("email")%>\n<% if (data.get("phone").length() > 0) {
                        out.print(data.get("phone") + "/");
                    }
                    if (data.get("fax").length() > 0) {
                        out.print(data.get("fax"));
                    }%> ', 83);
                doc.text(splitTitle,120, 32,'left');
                };
                doc.setFontSize(10);doc.setFontStyle('normal');doc.rect(7.5,55, 105, 7);doc.text('Ref:',9,60,'left');
                
                doc.autoTable({
                    bodyStyles: {
                        fillColor: [255, 255, 255],textColor: [40],fontStyle: 'normal',halign: 'left',
                        fontSize:8,
                    },
                    alternateRowStyles: {
                        fillColor: [255, 255, 255],
                        fontSize:8,
                    },
                    body: [['Signature du demandeur','Signature du magasinier'],
                       ['',''],['',''],['',''],
                    ],
                    
                    columnStyles: {
                    fillColor: [20,150,20],textColor: [70],fontStyle: 'normal',halign: 'left',
                    0: {cellWidth: 135},
                    1: {cellWidth: 50},
                    },
                    
                    
                    didParseCell: function (data) {
                        let rows = data.table.body;
                        if (data.row.index == 0) {    
                            data.cell.styles.fontSize = 10;
                        }
                    },
                    margin: { top: 56,bottom: 35,left:8,right:45,width: 100},
                })
                
                doc.autoTable({
                    bodyStyles: {
                        fillColor: [255, 255, 255],textColor: [40],fontStyle: 'normal',halign: 'left',
                        fontSize:8,
                    },
                    alternateRowStyles: {
                        fillColor: [255, 255, 255],
                        fontSize:8,
                    },
                    body: [
                       ['','Biskra le :    /   /'],
                    ],
                    
                    columnStyles: {
                    fillColor: [20,150,20],textColor: [70],fontStyle: 'normal',halign: 'left',
                    0: {cellWidth: 135},
                    1: {cellWidth: 50},
                    },
                    
                    footStyles: {fillColor: [255, 255, 255],textColor: [30],halign: 'left'},
                    foot: [['','EURL IMTRADE']],
                   
                    margin: { top: 56,bottom: 35,left:8,right:45,width: 100},
                })

                

               
            </div>

            <div id="editor" class="bypass" style="display:none;"></div>

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

    </body>
</html>
