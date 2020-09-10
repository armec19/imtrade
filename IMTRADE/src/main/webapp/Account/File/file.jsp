<%-- 
    Document   : index
    Created on : 9 mai 2020, 15:00:55
    Author     : Mechri
--%>
<%@page import="maps.Objet"%>
<%@page import="maps.Doctype"%>
<%@page import="maps.TemplateDocument"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.HashMap"%>
<%@page import="maps.Document"%>
<%@page import="maps.StructureDetails"%>
<%@page import="maps.Membre"%>
<%@page import="maps.Utilisateur"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    Utilisateur utilisateur = (Utilisateur) session.getAttribute("Utilisateur");
    Membre membre = (Membre) session.getAttribute("Membre");

    StructureDetails structureDetails = (StructureDetails) session.getAttribute("StructureDetails");

    TemplateDocument templateDocument = null;
    Document document = null;
    if (session.getAttribute("TemplateDocument") != null) {
        templateDocument = (TemplateDocument) session.getAttribute("TemplateDocument");

    }
    if (session.getAttribute("docimtrade") != null) {
        document = (Document) session.getAttribute("docimtrade");
        ((HashMap<String, String>) session.getAttribute("hashMap")).replace("projet", "" + document.getIdProjet());
        ((HashMap<String, String>) session.getAttribute("hashMap")).replace("nature", "" + document.getIdNature());
        ((HashMap<String, String>) session.getAttribute("hashMap")).replace("type", "" + document.getIdType());
        ((HashMap<String, String>) session.getAttribute("hashMap")).replace("designation", "" + document.getIdDesignation());
        ((HashMap<String, String>) session.getAttribute("hashMap")).replace("destinateurid", "" + document.getIdDestinataire());

    }
    Doctype doctype = (Doctype) session.getAttribute("Doctype");
    //session.setAttribute("docparams", docparams);


%>
<div id="prive">
    <jsp:include page='headfile.jsp' /> 
    <div class="row page-titles">
        <div class="col-md-5 align-self-center">
            <h4 class="text-themecolor"><%= doctype.getNomDocument()%></h4>
        </div>
        <div class="col-md-7 align-self-center text-right">
            <div class="d-flex justify-content-end align-items-center">
                <ol class="breadcrumb">
                    <li class="breadcrumb-item"><a href="javascript:void(0)"><%= doctype.getNomDocument()%></a></li>
                    <li class="breadcrumb-item active"><a href="javascript:void(0)">Document IMTrade</a></li>
                    <li class="breadcrumb-item active">Nouveau</li>
                </ol> 
            </div>
        </div>
    </div>


    <div class="main" >

        <div class="container" style="margin-bottom: 20px;">
            <div class="col-lg-8" style="height: 1300px;" >
                <form method="POST" id="signup-form" style="height: 1300px;" class="signup-form" enctype="multipart/form-data">

                    <jsp:include page='steps/parametrage.jsp' /> 

                    <jsp:include page='steps/contenu.jsp' /> 

                    <jsp:include page='steps/creation.jsp' />
                    <%
                        if (session.getAttribute("docimtrade") != null) {
                            if (document.getDocumentEtat().equals("validated")) {
                    %>
                    <jsp:include page='steps/confirmation.jsp' /> 
                    <%
                            }
                        }
                    %>
                    <%--<jsp:include page='steps/finish.jsp' />--%> 
                </form>
            </div>

            <div class="col-lg-4" id="contentx">
                <jsp:include page='content.jsp' />
            </div>
            <div class="form-row col-lg-4">
                <div class="form-group" style="width: auto;">
                    <input type="checkbox" name="agree-term"  id="auto-refresh" checked="checked" class="agree-term" />
                    <label for="auto-refresh" class="label-agree-term"><span><span></span></span>Actualisation automatique</label>
                </div>
            </div>
            <div class="form-row col-lg-4">
                <div class="col-lg-6">
                    <span class="mytooltip tooltip-effect-1">
                        <input type="button" value="Etablir un modèle" class="tooltip-item2 btn btn-info center-block">
                        <span class="tooltip-content4 clearfix">
                            <span class="tooltip-text2">
                                <input style="width: 100%;color: black;"  type="text" name="modelenom" id="modelenom" placeholder="Enter un nom du template" />
                                <br/>
                                <input type="button" value="Creer le modèle" id="creermodele" class="tooltip-item2 btn btn-info center-block ">
                            </span>
                        </span>
                    </span>
                </div>
                <div class="col-lg-6">
                    <span class="mytooltip tooltip-effect-2">
                        <input type="button" id="fullpage" value="Pleine page" class="btn btn-default center-block"> 
                        <span style="display:none" class="tooltip-content4 clearfix">
                            <span class="tooltip-text2"></span>
                        </span>
                    </span>
                </div>
            </div>  

            <div class="form-row">

            </div>  

        </div>	
    </div>

    <jsp:include page='footfile.jsp' />

</div>