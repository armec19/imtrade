<%@page import="java.util.Locale"%>
<%@page import="java.time.format.DateTimeFormatter"%>
<%@page import="java.time.LocalDate"%>
<%@page import="java.time.LocalDateTime"%>
<%@page import="module.ModelBean"%>
<%@page import="maps.TypeNature"%>
<%@page import="maps.DesignationNature"%>
<%@page import="maps.Nature"%>
<%@page import="maps.Projet"%>
<%@page import="maps.Destinateur"%>
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
        document = (Document) session.getAttribute("docimtrade");

    }
    if (session.getAttribute("docimtrade") != null) {
        document = (Document) session.getAttribute("docimtrade");

    }
    Doctype doctype = (Doctype) session.getAttribute("Doctype");
    //session.setAttribute("docparams", docparams);

    //session.setAttribute("newcode", null);
    Document newcode = (Document) ModelBean.Latest("Document", "idDocument");

    //session.setAttribute("newcode", newcode.getIdDocument());
    String time = LocalDateTime.now() + "";
    time = time.substring(0, 10);
    ((HashMap<String, String>) session.getAttribute("hashMap")).replace("dated", LocalDate.parse(time, DateTimeFormatter.BASIC_ISO_DATE.ofPattern("uuuu-MM-dd", Locale.UK)).format( DateTimeFormatter.ofPattern("dd/MM/uuuu", Locale.UK)));
    //time = LocalDate.parse(time, DateTimeFormatter.BASIC_ISO_DATE.ofPattern("uuuu-MM-dd", Locale.UK)).format( DateTimeFormatter.ofPattern("dd/MM/uuuu", Locale.UK));
    ((HashMap<String, String>) session.getAttribute("hashMap")).replace("num", newcode.getIdDocument() + "");
    
%>

<h3>
    Paramétrage
</h3>
<fieldset style="margin-left: -70px;">
    <div class="form-row" style="margin: 0px;margin-bottom: 35px;">
        <% if (templateDocument == null) {%>
        <h3 style='text-align:center;display: block;'>Type de document : <span class="h33" id="documentnameh33"><%= doctype.getNomDocument()%></span></h3>
            <% } else {%>
        <h3 style='text-align:center;display: block;'>Template n°<%=templateDocument.getIdTemplate()%> : <span class="h33" id="documentnameh33"><%=templateDocument.getNomTemplate()%></span></h3>
            <% } %>
    </div>
    <div class="container" style="width: 110%;
         overflow-x: auto;
         padding: 15px;
         height: 960px;">

        <div class="form-row">    
            <div id="the-basics" class="form-group">
                <label for="Ref">Référence*</label>
                <input style="width: 200px;" class="typeahead" type="text" name="Ref" id="Ref" placeholder="Entre le code de référence" />
            </div>
            <%
                if (doctype.getAbbrev().charAt(0) == 'B') {
            %>
            <div id="the-basics" class="form-group">
                <label for="NAgrement">N°Agrement*</label>
                <input style="width: 200px;" type="text" name="NAgrement" id="NAgrement" placeholder="Entre num d'agrement" />
            </div>
            <%
                }
            %>
        </div>

        <div class="form-row">
            <style>
                .form-group{
                    width: 205px;
                }


                .dropdown0 .select span,.dropdown0 .dropdown-menu {

                    font-size: 11px;
                }
                .dropdown0{
                    width: 200px;
                    margin-left: -15px;

                }
                input, label, textarea {
                    font-size: 11px;
                }
            </style>

            <div class="form-group">
                <label for="num">N°*</label>
                <input style="width: 200px;" type="text" name="num" id="num" class="input" placeholder="#### (Max 4'N)" maxlength="4" value="<%=newcode.getIdDocument()%>" />
            </div>
            <div class="form-group">
                <label for="dated">Date*</label>
                <input type="date" style="width: 200px;" name="dated" id="dated" placeholder="##/##/####" value="<%=time%>"   />
            </div>
            <div class="form-group">
                <label for="destinateur">Destinateur*</label>

                <div class="form-select">
                    <div class="dropdown dropdown0" style="">
                        <div class="select">
                            <span id="destinateur_span">Select destinateur</span>
                            <i class="fa fa-chevron-left"></i>
                        </div>
                        <input type="hidden" id="destinateur" name="destinateur">
                        <ul class="dropdown-menu" id="dropdown-destinateur">
                            <%
                                if (session.getAttribute("listedestinateur") != null) {
                                    List<Destinateur> destinateur = (List<Destinateur>) session.getAttribute("listedestinateur");
                                    for (int idx = 0; idx < destinateur.size(); idx++) {
                                        Destinateur elem = destinateur.get(idx);


                            %>
                            <li id="<%= elem.getIdDestinateur()%>"><%= elem.getNomDestinateur()%></li>
                                <%                                    }
                                    }
                                %>

                        </ul>
                    </div>
                </div>
            </div>  
        </div>

        <div class="form-row">
            <div class="form-group">
                <label for="projet">Projet*</label>
                <div class="form-select">
                    <div class="dropdown dropdown0">
                        <div class="select">
                            <span id="projet_span">Select projet</span>
                            <i class="fa fa-chevron-left"></i>
                        </div>
                        <input type="hidden" id="projet" name="Projet">
                        <ul class="dropdown-menu" id="dropdown-projet">
                            <%
                                if (session.getAttribute("listeprojet") != null) {
                                    List<Projet> projet = (List<Projet>) session.getAttribute("listeprojet");
                                    for (int idx = 0; idx < projet.size(); idx++) {
                                        Projet elem = projet.get(idx);


                            %>
                            <li id="<%= elem.getIdProjet()%>"><%= elem.getNomProjet()%></li>
                                <%                                    }
                                    }
                                %>

                        </ul>
                    </div>
                </div>
            </div>
            <div class="form-group">
                <label for="dated">Echéance*</label>
                <input style="width: 200px;" type="date" name="datef" id="datef"  placeholder="##/##/####" />
            </div>
            <div class="form-group">
                <label for="total">Total TTC*</label>
                <input style="width: 200px;" type="text" name="total" id="total" placeholder="Le TOTAL TTC" disabled="disabled"/>
            </div>

        </div>


        <div class="form-row">
            <div class="form-group">
                <label for="nature">Nature*</label>
                <div class="form-select">
                    <div class="dropdown dropdown0">
                        <div class="select">
                            <span id="nature_span">Select Nature</span>
                            <i class="fa fa-chevron-left"></i>
                        </div>
                        <input type="hidden" id="Nature" name="Nature">
                        <ul class="dropdown-menu" id="dropdown-nature">
                            <%
                                if (session.getAttribute("listenature") != null) {
                                    List<Nature> listenature = (List<Nature>) session.getAttribute("listenature");
                                    // out.print("$('#dropdown-nature').html(\"\")");
                                    for (int idx = 0; idx < listenature.size(); idx++) {
                                        Nature elem = listenature.get(idx);


                            %>
                            <li id="<%= elem.getIdNature()%>"><%= elem.getNomNature()%></li>
                                <%                                    }
                                    }
                                %>

                        </ul>
                    </div>
                </div>
            </div>
            <div class="form-group">
                <label for="type">Type*</label>
                <div class="form-select">
                    <div class="dropdown dropdown0">
                        <div class="select">
                            <span id="type_span">Select type</span>
                            <i class="fa fa-chevron-left"></i>
                        </div>
                        <input type="hidden" id="Type" name="Type">
                        <ul class="dropdown-menu" id="dropdown-type">
                            <%
                                if (session.getAttribute("listetype") != null) {
                                    List<TypeNature> listetype = (List<TypeNature>) session.getAttribute("listetype");
                                    // out.print("$('#dropdown-nature').html(\"\")");
                                    for (int idx = 0; idx < listetype.size(); idx++) {
                                        TypeNature elem = listetype.get(idx);


                            %>
                            <li id="<%= elem.getIdType()%>"><%= elem.getNomType()%></li>
                                <%                                    }
                                    }
                                %>

                        </ul>
                    </div>
                </div>
            </div>


            <div class="form-group">
                <label for="designation">Designation*</label>
                <div class="form-select">
                    <div class="dropdown dropdown0">
                        <div class="select">
                            <span id="designation_span">Select Designation</span>
                            <i class="fa fa-chevron-left"></i>
                        </div>
                        <input type="hidden" id="Designation" name="Designation">
                        <ul class="dropdown-menu" id="dropdown-designation">
                            <%
                                if (session.getAttribute("listedesignation") != null) {
                                    List<DesignationNature> listedesignation = (List<DesignationNature>) session.getAttribute("listedesignation");
                                    // out.print("$('#dropdown-nature').html(\"\")");
                                    for (int idx = 0; idx < listedesignation.size(); idx++) {
                                        DesignationNature elem = listedesignation.get(idx);


                            %>
                            <li id="<%= elem.getIdDes()%>"><%= elem.getNomDes()%></li>
                                <%                                    }
                                    }
                                %>
                        </ul>
                    </div>
                </div>
            </div>

        </div>
        <!--        <div class="form-row">
                    <div class="form-group">
                        <label for="demandeur">Demandeur*</label>
                        <input style="width: 200px;"  type="text" name="demandeur" id="demandeur" maxlength="26" placeholder="Enter un demandeur(Max 26 Mots)" />
                    </div>
                    <div class="form-group">
                        <label for="achteur">Achteur*</label>
                        <input style="width: 200px;"  type="text" name="achteur" id="achteur" maxlength="26" placeholder="Enter un achteur (Max 26 Mots)" />
                    </div>
                </div>-->

        <div class="form-row">


            <div class="form-group">
                <!--RegistreC-N°agrement/NIF/Article_I-->
                <label for="phone1">&nbsp;</label>
                <label for="agrr" style="font-size: 10px;">Email*</label>
                <input style="width: 200px;"  type="email" name="email" id="email" placeholder="Email(###@###.###)"/>
                <label for="agrr" style="font-size: 10px;">Tel*</label>
                <input style="width: 200px;"  type="tel" name="phone" id="phone" placeholder="Tel(##.##.##.##.##)"/>
                <label for="agrr" style="font-size: 10px;">Fax*</label>
                <input style="width: 200px;"  type="tel" name="fax" id="fax" placeholder="Fax(##.##.##.##.##)"/>

            </div>
            <div class="form-group">
                <label for="phone1" style="text-align: center;">Les coordonnées</label>
                <label for="rc" style="font-size: 10px;">Registre de commerce*</label>
                <input style="width: 200px;"  type="text" name="rc" id="rc" placeholder="Registre de commerce"/>
                <label for="agrr" style="font-size: 10px;">N° Agrement*</label>
                <input style="width: 200px;"  type="text" name="agrr" id="agrr" placeholder="N° Agrement"/>
                <label for="agrr" style="font-size: 10px;">N.I.F*</label>
                <input style="width: 200px;"  type="text" name="nif" id="nif" placeholder="N.I.F"/>

            </div>
            <div class="form-group">
                <!--RegistreC-N°agrement/NIF/Article_I-->
                <label for="phone1">&nbsp;</label>
                <label for="agrr" style="font-size: 10px;">A.I*</label>
                <input style="width: 200px;"  type="text" name="ai" id="ai" placeholder="A.I"/>
                <label for="agrr" style="font-size: 10px;">Adresse*</label>
                <input style="width: 200px;"  type="text" name="adr" id="adr" placeholder="Adresse"/>
            </div>

            <div class="form-group">
                <label for="description">Autre description</label>
                <textarea name="description" id="description" style="width: 610px;height: 100px;margin-top: 5px; " placeholder="Partie optionnel"></textarea>
            </div>
        </div>
    </div>   
    <!--    <div class="form-row">
            <div class="form-group">
    
                <input type="checkbox" name="agree-term" id="agree-term" class="agree-term" />
                <label for="agree-term" class="label-agree-term"><span><span></span></span>Contrat</label>
    
            </div>
        </div>-->
</fieldset>
