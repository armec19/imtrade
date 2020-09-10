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
    List<String[]> objet = (ArrayList<String[]>) session.getAttribute("ListObject");

    String num = "";
    String docname = "Projet";//
    out.print("<h3 class='h33' style='text-align:center'>Revue du "+docname+" en PDF<h3>");
   
    

    
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
        num = data.get("num") + "/"+structure.getCode()+"/";
        if (data.get("dated").length() > 8) {
            date = data.get("dated");
            num = num + data.get("dated").substring(8);
        }
    }
    
    
    //color
    String color="";
    if (structure.getCode().equals("RST")) {
        color="[27, 208, 141]";
    }
    if (structure.getCode().equals("ITNE")) {
        color="[51, 122, 183]";
    }
    if (structure.getCode().equals("DR")) {
        color="[249, 66, 66]";
    }
    if (structure.getCode().equals("DS")) {
        color="[249, 66, 66]";
    }

    if(session.getAttribute("Destinateurselected")!=null){ 
        Destinateur destinateur=(Destinateur)session.getAttribute("Destinateurselected");
    
        data.replace("destinateur","Doit à: "+destinateur.getNomDestinateur());
        data.replace("adr",destinateur.getAdrDestinateur());
        data.replace("rc",destinateur.getRegistreCommerce());
        data.replace("agrr",destinateur.getNAgrement());
        data.replace("nif",destinateur.getNif());
        data.replace("email",destinateur.getEmailDestinateur());
        data.replace("ai",destinateur.getArticleI());
        data.replace("phone",destinateur.getPhoneDestinateur());
        data.replace("fax",destinateur.getPhoneDestinateur());
        session.setAttribute("hashMap",data);
    } 


    //destinateur
    String des_nom=""; 
    String des_add=""; 
    String des_rc=""; 
    String des_agrr=""; 
    String des_nif=""; 
    String des_ai=""; 
    String des_email=""; 
    String des_phone=""; 

    if( data.get("destinateur").length()>0){ des_nom=data.get("destinateur"); }
    if( data.get("adr").length()>0){ des_add="Adresse: " + data.get("adr"); }
    if( data.get("rc").length()>0){ des_rc="R.C: " + data.get("rc"); }
    if( data.get("agrr").length()>0){ des_agrr="Agrement: " + data.get("agrr"); }
    if( data.get("nif").length()>0){ des_nif="N.I.F: " + data.get("nif"); }
    if( data.get("ai").length()>0){ des_ai="A.I: " + data.get("ai"); }
    if( data.get("email").length()>0){ des_email="Email: " + data.get("email"); }
    if( data.get("phone").length()>0 || data.get("fax").length()>0){
        des_phone="";
        if( data.get("phone").length()>0){ des_phone="Tel: " + data.get("phone")+"  "; }
        if( data.get("fax").length()>0){ des_phone+="Fax: " + data.get("fax"); }
    }
%>
<div id="content_js" style="display:none;">



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

    <% if (structure.getCode().equals("RST")) {
            out.print("imgData.src = 'ressources/logo_vente.jpg';");
        } %>
    <% if (structure.getCode().equals("ITNE")) {
            out.print("imgData.src = 'ressources/logo_itne.jpg';");
        } %>
    <% if (structure.getCode().equals("DR")) {
            out.print("imgData.src = 'ressources/logo_engineering.jpg';");
        } %>
    <% if (structure.getCode().equals("DS")) {
            out.print("imgData.src = 'ressources/logo_ds.jpg';");
        } %>; 


    doc.addImage(imgData, 6, 5, 90,27);

    var imgDataqr = document.createElement("img");
    imgDataqr.src = "http://localhost:8080/IMTRADE/webfiles/document<%=data.get("docpath")%>/Qrcode.png";


    doc.addImage(imgDataqr,180,doc.internal.pageSize.height - 30, 20, 20);

    doc.setFontSize(20);doc.setFontStyle('bold');doc.text('DOSSIER DE PROJET',120,20,'left');

    doc.setFontSize(15);doc.setFontStyle('bold');doc.text('N° :    /RST/20',110,50,'center');


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