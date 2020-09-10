<%@page import="maps.DocObjet"%>
<%@page import="maps.Doctype"%>
<%@page import="maps.Destinateur"%>
<%@page import="maps.Structure"%>
<%@page import="maps.StructureDetails"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.List"%>

<jsp:include page="/Content" />
<%
    HashMap<String, String> data = (HashMap<String, String>) session.getAttribute("hashMap");
    //List<String[]> objet = (ArrayList<String[]>) session.getAttribute("ListObject");
    
    Doctype doctype = (Doctype) session.getAttribute("Doctype");
    String docname = doctype.getNomDocument();//
    out.print("<h3 class='h33' style='text-align:center'>Revue du " + docname + " en PDF<h3>");
    String num = "";
    //List<DocObjet> docObjets=(List<DocObjet>)session.getAttribute("docObjet");
    
    double timbre = 0;
    Structure structure = (Structure) session.getAttribute("Structure");
    StructureDetails structureDetails = (StructureDetails) session.getAttribute("StructureDetails");
    String entete_nom = "EURL IMTRADE";
    String entete_capital = structureDetails.getCapital();
    String entete_adr = structureDetails.getAdresse();
    String entete_rc = structureDetails.getRc();
    String entete_nif = structureDetails.getNif();
    String entete_nis = structureDetails.getNis();
    String entete_art = structureDetails.getArt();
    String entete_rib = structureDetails.getRib();
    String entete_banque = structureDetails.getBanque();
    String entete_site = structureDetails.getSite();
    String entete_contact = structureDetails.getContact();

    //code
    String date = "--/--/----";
    if (!"".equals(data.get("dated")) || !"".equals(data.get("num"))) {
        num = data.get("num") + "/" + structure.getCode() + "/";
        if (data.get("dated").length() > 8) {
            date = data.get("dated");
            num = num + data.get("dated").substring(8);
        }
    }

    //color
    String color = "";
    if (structure.getCode().equals("RST")) {
        color = "[27, 208, 141]";
    }
    if (structure.getCode().equals("ITNE")) {
        color = "[51, 122, 183]";
    }
    if (structure.getCode().equals("DR")) {
        color = "[249, 66, 66]";
    }
    if (structure.getCode().equals("DS")) {
        color = "[249, 66, 66]";
    }

    if (session.getAttribute("Destinateurselected") != null) {
        Destinateur destinateur = (Destinateur) session.getAttribute("Destinateurselected");

        data.replace("destinateur", "Doit �: " + destinateur.getNomDestinateur());
        data.replace("adr", destinateur.getAdrDestinateur());
        data.replace("rc", destinateur.getRegistreCommerce());
        data.replace("agrr", destinateur.getNAgrement());
        data.replace("nif", destinateur.getNif());
        data.replace("email", destinateur.getEmailDestinateur());
        data.replace("ai", destinateur.getArticleI());
        data.replace("phone", destinateur.getPhoneDestinateur());
        data.replace("fax", destinateur.getPhoneDestinateur());
        session.setAttribute("hashMap", data);
    }

    //destinateur
    String des_nom = "";
    String des_add = "";
    String des_rc = "";
    String des_agrr = "";
    String des_nif = "";
    String des_ai = "";
    String des_email = "";
    String des_phone = "";

    if (data.get("destinateur").length() > 0) {
        des_nom = data.get("destinateur");
    }
    if (data.get("adr").length() > 0) {
        des_add = "Adresse: " + data.get("adr");
    }
    if (data.get("rc").length() > 0) {
        des_rc = "R.C: " + data.get("rc");
    }
    if (data.get("agrr").length() > 0) {
        des_agrr = "Agrement: " + data.get("agrr");
    }
    if (data.get("nif").length() > 0) {
        des_nif = "N.I.F: " + data.get("nif");
    }
    if (data.get("ai").length() > 0) {
        des_ai = "A.I: " + data.get("ai");
    }
    if (data.get("email").length() > 0) {
        des_email = "Email: " + data.get("email");
    }
    if (data.get("phone").length() > 0 || data.get("fax").length() > 0) {
        des_phone = "";
        if (data.get("phone").length() > 0) {
            des_phone = "Tel: " + data.get("phone") + "  ";
        }
        if (data.get("fax").length() > 0) {
            des_phone += "Fax: " + data.get("fax");
        }
    }

%>



<div id="content_js" style="display:none;">

    var doc = new jsPDF()

    doc.setProperties({
    title: "<%= docname%>",
    subject: "Document IMTRADE",
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
    <% if (structure.getCode().equals("RST")) {
            out.print("imgData.src = 'ressources/vente.jpg';");
        } %>
    <% if (structure.getCode().equals("ITNE")) {
            out.print("imgData.src = 'ressources/itne.jpg';");
        } %>
    <% if (structure.getCode().equals("DR")) {
            out.print("imgData.src = 'ressources/engineering.jpg';");
        } %>
    <% if (structure.getCode().equals("DS")) {
            out.print("imgData.src = 'ressources/ds.jpg';");
        }%>; 


    var options = {   pagesplit: true,'width': 550}

    doc.addImage(imgData, -7, -5, 226, 310);

    
    var imgDataqr = document.createElement("img");
    imgDataqr.src = "http://localhost:8080/IMTRADE/webfiles/document<%=data.get("docpath")%>/Qrcode.png";

    doc.addImage(imgData, -7, -5, 226, 310);
    
    
    /*var approved = document.createElement("img");
    approved.src = "ressources/approved.png";
     doc.addImage(approved, 103, 31, 8, 10);*/

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
    head: [['N�',  'D�signation', 'UM/Cond', 'Qt�', 'Prix U HT', 'Total HT']],

    bodyStyles: {4:{halign: 'right'}},

    headStyles: {
    //red
    fillColor: <%= color%>
    //green
    //headStyles: {fillColor: [27, 208, 141]},
    //blue
    //headStyles: {halign: 'center',fillColor: [51, 122, 183]},
    },

    columnStyles: {
    0: {halign: 'left',cellWidth: 10},
    1: {halign: 'left',cellWidth: 80},
    2: {halign: 'left',cellWidth: 25},
    3: {halign: 'left',cellWidth: 22},
    4: {halign: 'right',cellWidth: 29},
    5: {halign: 'right',cellWidth: 33},
    },

    body: [
    <%
        if (((List<String[]>) session.getAttribute("ListObject")).size() == 0) {
    %>
    ['','','','',''],
    <%
        }
    %>
    <% for (int idx = 0; idx < ((List<String[]>) session.getAttribute("ListObject")).size(); idx++) {
            String[] elem = ((List<String[]>) session.getAttribute("ListObject")).get(idx);
            //DocObjet docObjet=docObjets.get(idx);
    %>
    ['<%=idx + 1%>', '<%=elem[1]%>','<%=elem[2]%>','<%=elem[3]%>', '<%=elem[4]%>','<%=elem[5]%>'],
    <%
        }
    %>
    ],

    didDrawPage: function (data) {
    heights= data.table.height;
    var str = 'Page ' + doc.internal.getNumberOfPages()
    if (typeof doc.putTotalPages === 'function') {
    str = str + ' of ' + totalPagesExp
    }
    doc.setFontSize(7);

    doc.addImage(imgDataqr,6,doc.internal.pageSize.height - 20, 13, 13);
    var pageSize = doc.internal.pageSize
    var pageHeight = pageSize.height ? pageSize.height : pageSize.getHeight()
    doc.text(str, data.settings.margin.left+12, pageHeight-9, 'left')
    str = "<%= entete_site%>";  
    doc.setFontSize(7);
    doc.text(str, data.settings.margin.left+12, pageHeight - 13, 'left');
    str = "<%= entete_contact%>";  
    doc.setFontSize(7);
    doc.text(str, data.settings.margin.left+12, pageHeight - 15.5, 'left');
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
    doc.text(str, data.settings.margin.left+12, pageHeight - 13, 'left');
    str = "<%= entete_site%>";  
    doc.setFontSize(7);
    doc.text(str, data.settings.margin.left+12, pageHeight - 13, 'left');
    str = "<%= entete_contact%>";  
    doc.setFontSize(7);
    doc.text(str, data.settings.margin.left+12, doc.internal.pageSize.height - 18,'left');
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



    doc.setFontSize(11);doc.setFontStyle('bold');doc.setTextColor(255,255,255);doc.text("<%= docname%> N�: <%= num%>",8, 35,'left');
    doc.setFontSize(10);doc.setFontStyle('bold');doc.setTextColor(255,255,255);doc.text('<%= date%>',9,40,'left');
    doc.setFontSize(9);doc.setFontStyle('normal');doc.setTextColor(40);

    var xx='<%=des_nom%>';

    <% if (des_add.length() > 1) {%> xx=xx+'\n<%= des_add%>'; <% } %>
    <% if (des_rc.length() > 1) {%> xx=xx+'\n<%= des_rc%>'; <% } %>
    <% if (des_agrr.length() > 1) {%> xx=xx+'\n<%= des_agrr%>'; <% } %>
    <% if (des_nif.length() > 1) {%> xx=xx+'\n<%= des_nif%>'; <% } %>
    <% if (des_ai.length() > 1) {%> xx=xx+'\n<%= des_ai%>'; <% } %>
    <% if (des_email.length() > 1) {%> xx=xx+'\n<%= des_email%>'; <% } %>
    <% if (des_phone.length() > 1) {%> xx=xx+'\n<%= des_phone%>'; <% }%>




    var splitTitle = doc.splitTextToSize(xx, 83);
    doc.text(splitTitle,120, 32,'left');
    };
    <% if (data.get("Ref").length() > 0) {%>
    doc.setFontSize(10);doc.setFontStyle('bold');doc.setTextColor(60);doc.rect(7.5,55, 105, 7);doc.text('Ref:',8.5,60,'left');
    doc.setFontSize(10);doc.setFontStyle('normal');doc.setTextColor(60);doc.text('<%=data.get("Ref")%>',15.5,60,'left');
    <% }%>
    
    var tttc=0;

    <% if (data.get("totalttc").length() > 0) {%>
    tttc= parseInt(<%= data.get("totalttc")%>);
    <% }%>
    
    
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
    <% if (data.get("totalttc").length() > 0) { %>
    ['Montant du bon de commande arr�t� a la somme de :']
    <% } %>
    ],

    startY:66+heights,
    columnStyles: {
    fillColor: [255, 255, 255],textColor: [70],fontStyle: 'normal',halign: 'left',
    0: {cellWidth: 135},
    },

    footStyles: {fillColor: [255, 255, 255],textColor: [20],halign: 'left',fontSize:8},
    foot: [
    <% if (data.get("totalttc").length() > 0) { %>
    ['     '+NumberToLetter(tttc)+' DA']
    <% } %>
    ],
    margin: { top: 56,bottom: 35,left:8,right:45,width: 100},
    })


    doc.autoTable({

    styles: {
    lineColor: [255,255,255],
    lineWidth: 1,
    },

    bodyStyles: {
    fillColor: [222, 222, 222],
    },
    alternateRowStyles: {
    fillColor: [222, 222, 222],
    },

    didParseCell: function (data) {
    let rows = data.table.body;
    if (data.row.index == rows.length-1) { 

    data.cell.styles.fillColor =  <%= color%>;
    //G//[27, 208, 141],
    //B//[51, 122, 183],
    data.cell.styles.textColor = [255, 255, 255];
    data.cell.styles.fontStyle = 'bold';

    }else{
    fillColor: [222, 222, 222];
    }
    },

    footStyles: {
    0:{textColor: [255,255,255],
    halign: 'left',cellWidth:30},
    1:{textColor: [255,255,255],
    halign: 'right',cellWidth:30}
    },
    columnStyles: {0:{halign: 'left',cellWidth:29},1: {halign: 'right',cellWidth:33}},
    startY:66+heights,
    body: [['Total HT',' <%= data.get("totalht")%>'],
    <% if (!data.get("tva").equals("")) { %>
    <% if (Double.parseDouble(data.get("tva")) != 0) {%>
    ['TVA <%= data.get("%t")%>%',' <%= data.get("tva")%>'],
    <% }
        } %>
    <% if (!data.get("remise").equals("")) { %>
    <% if (Double.parseDouble(data.get("remise")) != 0) {%>
    ['Remise <%= data.get("%r")%>%',' <%= data.get("remise")%>'],
    <%      }
        } %>

    ['Total TTC',' <%= data.get("totalttc")%>']
    ],

    margin: { top: 56,bottom: 30,left:144,right:5,width: 100},
    })


    doc.autoTable({
    bodyStyles: {
    fillColor: [255, 255, 255],
    },
    alternateRowStyles: {
    fillColor: [255, 255, 255],
    },
    body: [
    ['','Biskra le : <%=date%>']
    ],

    columnStyles: {
    fillColor: [255, 255, 255],textColor: [40],fontStyle: 'normal',halign: 'left',
    0: {cellWidth: 135},
    1: {cellWidth: 50},
    },


    footStyles: {fillColor: [255, 255, 255],textColor: [40],fontSize:8,halign: 'left'},
    foot: [
    ['','EURL IMTRADE'],
    ],
    margin: { top: 56,bottom: 35,left:8,right:45,width: 100},
    })


</div>