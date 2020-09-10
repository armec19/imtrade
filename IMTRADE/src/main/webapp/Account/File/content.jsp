<%@page import="maps.Doctype"%>
<%@page import="java.util.List"%>
<%@page import="maps.Document"%>
<%@page import="maps.DesignationNature"%>
<%@page import="maps.TypeNature"%>
<%@page import="maps.Nature"%>
<%@page import="maps.Projet"%>
<%@page import="maps.Destinateur"%>

<div class="row-fluid" style="">
    <div class="span6" style="float: right; height: 550px;width: 100%;" >
        <div id="preview-pane" style="height: 550px;position:relative; z-index:999"></div>
    </div>
    <%
        Doctype doctyped = (Doctype) session.getAttribute("Doctype");
        String pagename = doctyped.getAbbrev();
    %>

    <% if (pagename.equals("BC")) { %>
    <jsp:include page="ressources/textBC.jsp" />
    <% } %>

    <% if (pagename.equals("BE")) { %>
    <jsp:include page="ressources/textBE.jsp" />
    <% } %>

    <% if (pagename.equals("BL")) { %>
    <jsp:include page="ressources/textBL.jsp" />
    <% } %>

    <% if (pagename.equals("BM")) { %>
    <jsp:include page="ressources/textBM.jsp" />
    <% } %>

    <% if (pagename.equals("BRes")) { %>
    <jsp:include page="ressources/textBRes.jsp" />
    <% } %>

    <% if (pagename.equals("BRet")) { %>
    <jsp:include page="ressources/textBRet.jsp" />
    <% } %>

    <% if (pagename.equals("BSit")) { %>
    <jsp:include page="ressources/textBSit.jsp" />
    <% } %>

    <% if (pagename.equals("BSor")) { %>
    <jsp:include page="ressources/textBSor.jsp" />
    <% } %>

    <% if (pagename.equals("DA")) { %>
    <jsp:include page="ressources/textDA.jsp" />
    <% } %>

    <% if (pagename.equals("Fac")) { %>
    <jsp:include page="ressources/textFac.jsp" />
    <% } %>

    <% if (pagename.equals("O")) {%>
    <jsp:include page="ressources/textO.jsp" />
    <% } %>

    <% if (pagename.equals("P")) {%>
    <jsp:include page="ressources/textP.jsp" />
    <% }%>

    <% if (pagename.equals("OM")) {%>
    <jsp:include page="ressources/textOM.jsp" />
    <% }%>
    <% if (pagename.equals("BG")) {%>
    <jsp:include page="ressources/textBG.jsp" />
    <% }%>

    <div id="editor" class="bypass" style="display:none;"></div>

    <!--    <div class="controls" style="display: none;" >
            <div class="pull-right">
                <a href="#" class="btn btn-primary">Download Your Code</a>
                <a href="#" class="btn btn-primary download-pdf">Download PDF</a>
            </div>
    
            <label class="checkbox">
                <input type="checkbox" id="auto-refresh" checked="checked"> Auto refresh on changes?
            </label>
    
            <div class="alert hide">
                Auto refresh disabled for this
            </div>
    
        </div>-->

</div>
<div class="clerfix"></div>	
<script src="steps/css/chiffreenlettre.js" type="text/javascript" charset="utf-8"></script>
<script src="PDF/examples/js/ace.js" type="text/javascript" charset="utf-8"></script>

<!-- Scripts in development mode -->
<script type="text/javascript" src="PDF/dist/jspdf.debug.js"></script>		
<script src="PDF/libs/faker.min.js"></script>
<script src="PDF/libs/jspdf.plugin.autotable.js"></script>
<script type="text/javascript" src="PDF/examples/js/pdfobject.min.js"></script>
<script type="text/javascript" src="PDF/examples/js/editor.js"></script>

<%
    if (session.getAttribute("Destinateurselected") != null) {
        Destinateur destinateur = (Destinateur) session.getAttribute("Destinateurselected");
        Projet projet = (Projet) session.getAttribute("Projet");
        Nature nature = (Nature) session.getAttribute("Nature");
        TypeNature tnature = (TypeNature) session.getAttribute("TypeNature");
        DesignationNature dnature = (DesignationNature) session.getAttribute("DesignationNature");
        Document document = (Document) session.getAttribute("docimtrade");

        out.print("<script>");
        out.print("$(document).ready(function () {");

        if (session.getAttribute("listenature") != null) {
            List<Nature> listenature = (List<Nature>) session.getAttribute("listenature");
            out.print("$('#dropdown-nature').html(\"\");");

            for (int idx = 0; idx < listenature.size(); idx++) {
                Nature elem = listenature.get(idx);
                out.print("$('#dropdown-nature').html($('#dropdown-nature').html()+\"<li id='" + elem.getIdNature() + "'>" + elem.getNomNature() + "</li>\");");
            }
        }

        if (session.getAttribute("listetype") != null) {
            List<TypeNature> listetype = (List<TypeNature>) session.getAttribute("listetype");
            out.print("$('#dropdown-type').html(\"\");");
            for (int idx = 0; idx < listetype.size(); idx++) {
                TypeNature elem = listetype.get(idx);
                out.print("$('#dropdown-type').html($('#dropdown-type').html()+\"<li id='" + elem.getIdType() + "'>" + elem.getNomType() + "</li>\");");
            }
        }

        if (session.getAttribute("listedesignation") != null) {
            List<DesignationNature> listedesignation = (List<DesignationNature>) session.getAttribute("listedesignation");
            out.print("$('#dropdown-designation').html(\"\");");
            for (int idx = 0; idx < listedesignation.size(); idx++) {
                DesignationNature elem = listedesignation.get(idx);
                out.print("$('#dropdown-designation').html($('#dropdown-designation').html()+\"<li id='" + elem.getIdDes() + "'>" + elem.getNomDes() + "</li>\");");
            }
        }
        if (destinateur != null) {
            out.print("$('#destinateur_span').text('" + destinateur.getNomDestinateur() + "');");
            out.print("$('#destinateur_span').addClass($(this).attr(" + destinateur.getIdDestinateur() + "));");
            out.print("$('#rc').val('" + destinateur.getRegistreCommerce() + "');");
            out.print("$('#agrr').val('" + destinateur.getNAgrement() + "');");
            out.print("$('#nif').val('" + destinateur.getNif() + "');");
            out.print("$('#ai').val('" + destinateur.getArticleI() + "');");
            out.print("$('#adr').val('" + destinateur.getAdrDestinateur() + "');");
            out.print("$('#email').val('" + destinateur.getEmailDestinateur() + "');");
            out.print("$('#phone').val('" + destinateur.getPhoneDestinateur() + "');");
            out.print("$('#fax').val('" + destinateur.getFaxDestinateur() + "');");

        }
        if (projet != null) {
            out.print("$('#projet_span').text('" + projet.getNomProjet() + "');");
            out.print("$('#projet_span').addClass($(this).attr(" + projet.getIdProjet() + "));");
        }
        if (nature != null) {
            out.print("$('#nature_span').text('" + nature.getNomNature() + "');");
            out.print("$('#nature_span').addClass($(this).attr(" + nature.getIdNature() + "));");
        }
        if (tnature != null) {
            out.print("$('#type_span').text('" + tnature.getNomType() + "');");
            out.print("$('#type_span').addClass($(this).attr(" + tnature.getIdType() + "));");
        }
        if (dnature != null) {
            out.print("$('#designation_span').text('" + dnature.getNomDes() + "');");
            out.print("$('#designation_span').addClass($(this).attr(" + dnature.getIdDes() + "));");
        }
        if (session.getAttribute("docimtrade") != null) {
            out.print("$('#description').val('" + document.getCommentaire() + "');");
        }

        out.print("});");
        out.print("</script>");
        //session.setAttribute("Destinateurselected", null);
    }
%>
<div id="scriptable">

</div>