<%@page import="maps.DocObjet"%>
<%@page import="maps.TemplateDocument"%>
<%@page import="maps.Document"%>
<%@page import="maps.DocObjetSn"%>
<%@page import="java.util.ArrayList"%>
<%@page import="maps.Objet"%>
<%@page import="module.ModelBean"%>
<%@page import="java.util.List"%>
<%@page import="maps.ObjetType"%>
<%@page import="maps.Doctype"%>
<%@page import="maps.Structure"%>
<%@page import="maps.StructureDetails"%>
<%
    Doctype doctype = (Doctype) session.getAttribute("Doctype");
    Structure structure = (Structure) session.getAttribute("Structure");
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
%>
<h3>
    Contenu
</h3>
<fieldset>
    <style>
        .table>tbody>tr>td, .table>tbody>tr>th, .table>tfoot>tr>td, .table>tfoot>tr>th, .table>thead>tr>td, .table>thead>tr>th {

            border-top: 0px solid #fff;
            height: 10px;

        }
    </style>

    <div class="form-check" style="background-image: 
         <% if (structure.getCode().equals("RST")) {
                 out.print("url(ressources/vente.jpg)");
             } %>
         <% if (structure.getCode().equals("ITNE")) {
                 out.print("url(ressources/itne.jpg)");
             } %>
         <% if (structure.getCode().equals("DR")) {
                 out.print("url(ressources/engineering.jpg)");
             } %>
         <% if (structure.getCode().equals("DS")) {
                 out.print("url(ressources/ds.jpg)");
             }%>; 

         background-size: contain;
         background-repeat: no-repeat;
         height: 1150px;
         width: 755px;
         margin-top: -60px;
         margin-left: -105px;">

        <div class="col-lg-offset-7 col-lg-4 text-right" style="line-height: 8px;
             margin-top: -100px;">

            <span style="text-align: right;
                  font-size: 10px;">
                <%=entete_nom%><br/>
                <%=entete_capital%><br/>
                <%=entete_adr%><br/>
                <%=entete_rc%><br/>
                <%=entete_nif%><br/>
                <%=entete_nis%><br/>
                <%=entete_art%><br/>
                <%=entete_rib%><br/>
                <%=entete_banque%><br/>

            </span>

        </div>

        <div class="col-md-12" style="margin-top: 60px;">
            <div class="col-lg-6" style="
                 margin-top: -35px;
                 margin-left: -19px;
                 line-height: 20px;">
                <span id="numenreal" style="margin-left: 30px;font-size:15px;color:white;font-weight: bold;"><%= doctype.getNomDocument()%> N°: --/--/-- </span>
                <br/>
                <span id="dateenreal" style="margin-left: 35px;color:#bbdcff;font-weight: bold;">--/--/----</span>
            </div>
            <div class="col-lg-offset-1 col-md-5"  style="margin-top: -55px;margin-left: 30px;">
                <textarea id="destenreal"  disabled="disabled" style="height: 145px;width: 108%;line-height: 15px;border-color: transparent;" >Doit à :</textarea>
            </div>
            <div class="col-lg-12" style="">
                <%
                    if (doctype.getAbbrev().equals("BC") || doctype.getAbbrev().equals("Fac") || doctype.getAbbrev().equals("O")) {
                %>

                <main id="table" style="height: 300px;overflow-y: auto;margin-right: -15px;margin-left: -25px;">
                    <table class="table" id="tab_logic">
                        <thead>
                            <tr style="color:white;">
                                <th class="col-md-1 th text-left">Objet</th>
                                <th class="col-md-3 th text-left">Designation</th>
                                <th class="col-md-2 th text-left">U.M/Cond</th>
                                <th class="col-md-2 th text-center">Qte</th>
                                <th class="col-md-1 th text-right">PU HT</th>
                                <th class="col-md-2 th text-right">Total HT</th>
                                <th class="th text-center">#</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                                if (session.getAttribute("docimtrade") != null) {
                                    //if (!document.getDocumentEtat().equals("validated") && !document.getDocumentEtat().equals("created") && !document.getDocumentEtat().equals("confirmed")) {
                                    if (document.getDocumentEtat().equals("templated")) {
                            %>
                            <tr id='tab_logicaddr0' class="tab_logicfirst-tr">
                                <td id="the-basics" class="static">
                                    <input style="font-size: 13px;padding: 0px;background: #00000000;border-color: transparent;" autofocus type="text" name='type'  placeholder='type' id="typearticle" class="typeahead1 effect-4 text-left type">
                                </td>
                                <td id="the-basics" class="static">
                                    <input style="font-size: 13px;padding: 0px;background: #00000000;border-color: transparent;" autofocus type="text" name='product' placeholder='produit' id="productarticle" class="typeahead2 effect-4 text-left product">
                                </td>
                                <td class="static">
                                    <input style="font-size: 13px;padding: 0px;background: #00000000;border-color: transparent;" autofocus type="text" name='umcond' placeholder='UM/Cond' id="umcondarticle" class="effect-4 text-left umcond">
                                </td>
                                <td class="static">
                                    <input style="font-size: 13px;padding: 0px;background: #00000000;border-color: transparent;" class="effect-4 text-center qty"  type="number" name='qty' id="qtyarticle" placeholder='0' step="0" min="0" />
                                </td>
                                <td class="static">
                                    <input style="font-size: 13px;padding: 0px;background: #00000000;border-color: transparent;" class="effect-4 text-right price"  type="number" name='price' id="pricearticle" placeholder='0.00' step="0.00" min="0"  />
                                </td>
                                <td class="static">
                                    <input style="font-size: 13px;padding: 0px;background: #00000000;border-color: transparent;" class="effect-4 text-right total" type="number" name='total' id="totalarticle" placeholder='0.00' readonly/>
                                </td>

                                <td class="static"><button type="button" style="margin-top: 10px;border-radius: 20px;" class="button green_bc"><i class="glyphicon glyphicon-plus" style="font-size: 25px;font-weight: bold;"></i></button></td>
                            </tr>
                            <%
                                }
                            } else {
                            %>
                            <tr id='tab_logicaddr0' class="tab_logicfirst-tr">
                                <td id="the-basics" class="static">
                                    <input style="font-size: 13px;padding: 0px;background: #00000000;border-color: transparent;" autofocus type="text" name='type'  placeholder='type' id="typearticle" class="typeahead1 effect-4 text-left type">
                                </td>
                                <td id="the-basics" class="static">
                                    <input style="font-size: 13px;padding: 0px;background: #00000000;border-color: transparent;" autofocus type="text" name='product' placeholder='produit' id="productarticle" class="typeahead2 effect-4 text-left product">
                                </td>
                                <td class="static">
                                    <input style="font-size: 13px;padding: 0px;background: #00000000;border-color: transparent;" autofocus type="text" name='umcond' placeholder='UM/Cond' id="umcondarticle" class="effect-4 text-left umcond">
                                </td>
                                <td class="static">
                                    <input style="font-size: 13px;padding: 0px;background: #00000000;border-color: transparent;" class="effect-4 text-center qty"  type="number" name='qty' id="qtyarticle" placeholder='0' step="0" min="0" />
                                </td>
                                <td class="static">
                                    <input style="font-size: 13px;padding: 0px;background: #00000000;border-color: transparent;" class="effect-4 text-right price"  type="number" name='price' id="pricearticle" placeholder='0.00' step="0.00" min="0"  />
                                </td>
                                <td class="static">
                                    <input style="font-size: 13px;padding: 0px;background: #00000000;border-color: transparent;" class="effect-4 text-right total" type="number" name='total' id="totalarticle" placeholder='0.00' readonly/>
                                </td>

                                <td class="static"><button type="button" style="margin-top: 10px;border-radius: 20px;" class="button green_bc"><i class="glyphicon glyphicon-plus" style="font-size: 25px;font-weight: bold;"></i></button></td>
                            </tr>
                            <%
                                }

                            %>

                            <%                                //
                                if (session.getAttribute("ListObject") != null) {
                                    List<String[]> doccontents = (List<String[]>) session.getAttribute("ListObject");
                                    List<DocObjet> docObjets = (List<DocObjet>) session.getAttribute("docObjet");
                                    for (int idx = 0; idx < ((List<String[]>) session.getAttribute("ListObject")).size(); idx++) {
                                        String[] objet = ((List<String[]>) session.getAttribute("ListObject")).get(idx);
                                        DocObjet docObjet = docObjets.get(idx);
                                        
                            %>
                            <tr style="font-size: 13px;border-top: 1px solid #daeaf1;">
                                <td class="text-left" style="padding-top: 15px;"><%= objet[0]%></td>
                                <td class="text-left" style="padding-top: 15px;"><%= objet[1]%></td>
                                <%--td class="text-left" style="padding-top: 15px;"><%= docObjet.getCond()%></td--%>
                                <td class="text-left " style="padding-top: 15px;"><%=objet[2]%></td>
                                <td class="text-center " style="padding-top: 15px;"><%=objet[3]%></td>
                                <td class="text-left" style="padding-top: 15px;"><%= objet[4]%></td>
                                <td class="text-right total1" style="padding-top: 15px;"><%= objet[5]%></td>
                                <td class="static">
                                    <span class="button red" style="border-radius: 20px;"><i class="glyphicon glyphicon-minus" style="font-size: 25px;font-weight: bold;"></i></span>
                                </td>
                            </tr>
                            <%
                                    }
                                }
                            %>
                        </tbody>
                    </table>
                    <div class="alert">
                        <h2>Erreur !</h2>
                        <p id="texterror"></p>
                        <input type="button" style="width: auto;margin-bottom: 10px;" value="Retour" class="btn btn-danger center-block button remove"> 
                    </div>
                </main>
                <%
                    }
                %>


                <%
                    if (doctype.getAbbrev().equals("DA")) {
                %>


                <main id="table" style="height: 300px;overflow-y: auto;margin-right: 15px;">
                    <table class="table" id="tab_logic">
                        <thead>
                            <tr style="color:white;">
                                <th class="col-md-2 th text-left">Objet</th>
                                <th class="col-md-4 th text-left">Designation</th>
                                <th class="col-md-2 th text-center">Qte</th>
                                <th class="col-md-2 th text-right">Prix U HT</th>
                                <th class="col-md-2 th text-right">Total HT</th>
                                <th class="th text-center">#</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                                if (session.getAttribute("docimtrade") != null) {
                                    //if (!document.getDocumentEtat().equals("validated") && !document.getDocumentEtat().equals("created") && !document.getDocumentEtat().equals("confirmed")) {
                                    if (document.getDocumentEtat().equals("templated")) {
                            %>
                            <tr id='tab_logicaddr0' class="tab_logicfirst-tr">
                                <td id="the-basics" class="static">
                                    <input style="font-size: 13px;padding: 0px;background: #00000000;border-color: transparent;" autofocus type="text" name='type'  placeholder='type' id="typearticle" class="typeahead1 effect-4 text-left type">
                                </td>
                                <td id="the-basics" class="static">
                                    <input style="font-size: 13px;padding: 0px;background: #00000000;border-color: transparent;" autofocus type="text" name='product' placeholder='produit' id="productarticle" class="typeahead2 effect-4 text-left product">
                                </td>
                                <td class="static">
                                    <input style="font-size: 13px;padding: 0px;background: #00000000;border-color: transparent;" class="effect-4 text-center qty"  type="number" name='qty' id="qtyarticle" placeholder='0' step="0" min="0" />
                                </td>
                                <td class="static">
                                    <input style="font-size: 13px;padding: 0px;background: #00000000;border-color: transparent;" class="effect-4 text-right price"  type="number" name='price' id="pricearticle" placeholder='0.00' step="0.00" min="0"  />
                                </td>
                                <td class="static">
                                    <input style="font-size: 13px;padding: 0px;background: #00000000;border-color: transparent;" class="effect-4 text-right total" type="number" name='total' id="totalarticle" placeholder='0.00' readonly/>
                                </td>

                                <td class="static"><button type="button" style="margin-top: 10px;border-radius: 20px;" class="button green"><i class="glyphicon glyphicon-plus" style="font-size: 25px;font-weight: bold;"></i></button></td>
                            </tr>
                            <%
                                }
                            } else {
                            %>
                            <tr id='tab_logicaddr0' class="tab_logicfirst-tr">
                                <td id="the-basics" class="static">
                                    <input style="font-size: 13px;padding: 0px;background: #00000000;border-color: transparent;" autofocus type="text" name='type'  placeholder='type' id="typearticle" class="typeahead1 effect-4 text-left type">
                                </td>
                                <td id="the-basics" class="static">
                                    <input style="font-size: 13px;padding: 0px;background: #00000000;border-color: transparent;" autofocus type="text" name='product' placeholder='produit' id="productarticle" class="typeahead2 effect-4 text-left product">
                                </td>
                                <td class="static">
                                    <input style="font-size: 13px;padding: 0px;background: #00000000;border-color: transparent;" class="effect-4 text-center qty"  type="number" name='qty' id="qtyarticle" placeholder='0' step="0" min="0" />
                                </td>
                                <td class="static">
                                    <input style="font-size: 13px;padding: 0px;background: #00000000;border-color: transparent;" class="effect-4 text-right price"  type="number" name='price' id="pricearticle" placeholder='0.00' step="0.00" min="0"  />
                                </td>
                                <td class="static">
                                    <input style="font-size: 13px;padding: 0px;background: #00000000;border-color: transparent;" class="effect-4 text-right total" type="number" name='total' id="totalarticle" placeholder='0.00' readonly/>
                                </td>

                                <td class="static"><button type="button" style="margin-top: 10px;border-radius: 20px;" class="button green"><i class="glyphicon glyphicon-plus" style="font-size: 25px;font-weight: bold;"></i></button></td>
                            </tr>
                            <%
                                }

                            %>

                            <%                               
                                //
                                if (session.getAttribute("ListObject") != null) {
                                    List<String[]> doccontents = (List<String[]>) session.getAttribute("ListObject");
                                    for (int idx = 0; idx < doccontents.size(); idx++) {
                                        String[] objet = doccontents.get(idx);
                            %>
                            <tr style="font-size: 13px;border-top: 1px solid #daeaf1;">
                                <td class="text-left" style="padding-top: 15px;"><%= objet[0]%></td>
                                <td class="text-left" style="padding-top: 15px;"><%= objet[1]%></td>
                                <td class="text-center " style="padding-top: 15px;"><%=objet[2]%></td>
                                <td class="text-right " style="padding-top: 15px;"><%= objet[3]%></td>
                                <td class="text-right total1" style="padding-top: 15px;"><%= objet[4]%></td>
                                <td class="static">
                                    <span class="button red" style="border-radius: 20px;"><i class="glyphicon glyphicon-minus" style="font-size: 25px;font-weight: bold;"></i></span>
                                </td>
                            </tr>
                            <%   }
                                }
                            %>
                        </tbody>
                    </table>
                    <div class="alert">
                        <h2>Erreur !</h2>
                        <p id="texterror"></p>
                        <input type="button" style="width: auto;margin-bottom: 10px;" value="Retour" class="btn btn-danger center-block button remove"> 
                    </div>
                </main>
                <%
                    }
                    if (doctype.getAbbrev().charAt(0) == 'B' && !doctype.getAbbrev().equals("BC")) {
                %>
                <main id="table" style="height: 300px;overflow-y: auto;margin-right: 15px;">
                    <table class="table" id="tab_logicsn">
                        <thead>
                            <tr style="color:white;">
                                <th class="col-md-2 th text-left">Objet</th>
                                <th class="col-md-4 th text-left">Designation</th>
                                <th class="col-md-1 th text-center">Qte</th>
                                <th class="col-md-2 th text-right">U.M</th>
                                <th class="col-md-3 th text-right">Condition</th>
                                <th class="th text-center">#</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                                if (session.getAttribute("docimtrade") != null) {
                                    if (!document.getDocumentEtat().equals("validated") && !document.getDocumentEtat().equals("created") && !document.getDocumentEtat().equals("confirmed")) {
                            %>
                            <tr id='tab_logicaddr0' class="tab_logicsnfirst-tr">
                                <td id="the-basics" class="static">
                                    <input style="font-size: 13px;padding: 0px;background: #00000000;border-color: transparent;" autofocus type="text" name='type'  placeholder='type' id="typearticle" class="typeahead1 effect-4 text-left type">
                                </td>
                                <td id="the-basics" class="static">
                                    <input style="font-size: 13px;padding: 0px;background: #00000000;border-color: transparent;" autofocus type="text" name='product' placeholder='produit' id="productarticle" class="typeahead2 effect-4 text-left product">
                                </td>
                                <td class="static">
                                    <input type="button" id="qtymodal" value="0"  class="tooltip-item2 btn btn-default center-block" data-toggle="modal" data-target="#exampleModal">
                                </td>
                                <td class="static">
                                    <input style="font-size: 13px;padding: 0px;background: #00000000;border-color: transparent;" class="effect-4 text-right UM"  type="text" name='UM' id="UM" placeholder='U.M' value="/" />
                                </td>
                                <td class="static">
                                    <input style="font-size: 13px;padding: 0px;background: #00000000;border-color: transparent;" class="effect-4 text-right Cond" type="text" name='Cond' id="Cond" placeholder='Cond' value="/" />
                                </td>

                                <td class="static"><button type="button" style="margin-top: 10px;border-radius: 20px;" class="button greensn"><i class="glyphicon glyphicon-plus" style="font-size: 25px;font-weight: bold;"></i></button></td>
                            </tr>
                            <%
                                }
                            } else {
                            %>
                            <tr id='tab_logicaddr0' class="tab_logicsnfirst-tr">
                                <td id="the-basics" class="static" >
                                    <input style="font-size: 13px;padding: 0px;background: #00000000;border-color: transparent;" autofocus type="text" name='type'  placeholder='type' id="typearticle" class="typeahead1 effect-4 text-left type">
                                </td>
                                <td id="the-basics" class="static">
                                    <input style="font-size: 13px;padding: 0px;background: #00000000;border-color: transparent;" autofocus type="text" name='product' placeholder='produit' id="productarticle" class="typeahead2 effect-4 text-left product">
                                </td>
                                <td class="static">
                                    <input type="button" id="qtymodal" value="0" class="tooltip-item2 btn btn-default center-block " data-toggle="modal" >
                                </td>
                                <td class="static">
                                    <input style="font-size: 13px;padding: 0px;background: #00000000;border-color: transparent;" class="effect-4 text-right UM"  type="text" name='UM' id="UM" placeholder='U.M' value="/" />
                                </td>
                                <td class="static">
                                    <input style="font-size: 13px;padding: 0px;background: #00000000;border-color: transparent;" class="effect-4 text-right Cond" type="text" name='Cond' id="Cond" placeholder='Cond' value="/" />
                                </td>

                                <td class="static"><button type="button" style="margin-top: 10px;border-radius: 20px;" class="button greensn"><i class="glyphicon glyphicon-plus" style="font-size: 25px;font-weight: bold;"></i></button></td>
                            </tr>
                            <%
                                }
                            %>
                        </tbody>
                    </table>
                    <div class="alert">
                        <h2>Erreur !</h2>
                        <p id="texterror"></p>
                        <input type="button" style="width: auto;margin-bottom: 10px;" value="Retour" class="btn btn-danger center-block button remove"> 
                    </div>
                </main>
                <%                    }
                %>
                <div class="row clearfix" style="margin-top:20px;margin-right: 10px;">
                    <%
                        if (doctype.getAbbrev().equals("O") || doctype.getAbbrev().equals("Fac")) {
                    %>
                    <div class="col-lg-5" style="height: 380px;
                         overflow-x: auto;">
                        <label>Conditions réglementaires :</label>
                        <div id="the-basics" class="form-group" style="width: auto;padding-bottom: 10px;border-bottom: solid 1px #c8cacc;">
                            <input class="col-lg-1" type="checkbox" id="cond1" style="width: 17px;display: block;">
                            <label class="col-lg-11" for="cond1" style=" margin-top: 13px;font-size: 13px;margin-bottom: 13px;">Offre particulière :</label>
                            <span style="font-size: 13px;">- Les prix ne sont valides que pour la totalité de l'offre. </span>

                        </div>
                        <div id="the-basics" class="form-group" style="width: auto;padding-bottom: 10px;border-bottom: solid 1px #c8cacc;">

                            <input class="col-lg-1" type="checkbox" id="cond2" style="width: 17px;display: block;">
                            <label class="col-lg-11" for="cond2" style=" margin-top: 13px;font-size: 13px;margin-bottom: 13px;">Mode de reglement :</label>

                            <input style="width: 200px;" class="typeahead3" type="text" name="modeR" id="modeR"  placeholder="Mode de reglement" />

                            <!--                            <input type="checkbox" name="agree-term"  id="cond2"  class="agree-term" />
                                                        <label  for="cond2" class="label-agree-term"><span></span> Mode de reglement :
                                                            <br/>
                                                            <input style="width: 200px;" class="typeahead3" type="text" name="modeR" id="modeR"  placeholder="Mode de reglement" />
                                                            <br/>
                                                        </label>-->
                        </div>
                        <div id="the-basics" class="form-group" style="width: auto;padding-bottom: 10px;border-bottom: solid 1px #c8cacc;">
                            <input class="col-lg-1" type="checkbox" id="cond3" style="width: 17px;display: block;">
                            <label class="col-lg-11" for="cond3" style=" margin-top: 13px;font-size: 13px;margin-bottom: 13px;">Mode de livraison :</label>

                            <input style="width: 200px;" class="typeahead4 col-md-12" type="text" name="modeL" id="modeL"  placeholder="Mode de livraison" />

                        </div>
                        <div class="form-group" style="width: auto;padding-bottom: 10px;border-bottom: solid 1px #c8cacc;">
                            <input class="col-lg-1" type="checkbox" id="cond4" style="width: 17px;display: block;">
                            <label class="col-lg-11" for="cond4" style=" margin-top: 13px;font-size: 13px;margin-bottom: 13px;">Délais de livraison :</label>

                            <input style="width: 200px;" type="date" name="delaisl" id="delaisl"  placeholder="##/##/####" />

                            <!--                            <input type="checkbox" name="agree-term"  id="cond4"  class="agree-term" />
                                                        <label for="cond4" class="label-agree-term"><span><span></span></span>
                                                            Délais de livraison : 
                                                            <input style="width: 200px;" type="date" name="delaisl" id="delaisl"  placeholder="##/##/####" />
                                                        </label>-->
                        </div>
                        <div class="form-group" style="width: auto;padding-bottom: 10px;border-bottom: solid 1px #c8cacc;">
                            <input class="col-lg-1" type="checkbox" id="cond5" style="width: 17px;display: block;">
                            <label class="col-lg-11" for="cond5" style=" margin-top: 13px;font-size: 13px;margin-bottom: 13px;">Validité de l'offre :</label>

                            <input style="width: 200px;" type="date" name="validiteo" id="validiteo"  placeholder="##/##/####" />

                            <!--                            <input type="checkbox" name="agree-term"  id="cond5"  class="agree-term" />
                                                        <label for="cond5" class="label-agree-term"><span><span></span></span>
                                                            Validité de l'offre : 
                                                            <input style="width: 200px;" type="date" name="validiteo" id="validiteo"  placeholder="##/##/####" />
                                                        </label>-->
                        </div>

                    </div>
                    <%                        } else {
                            out.print("<div class='col-lg-5'></div>");
                        }
                    %>
                    <%
                        if ((doctype.getAbbrev().charAt(0) != 'B' && !doctype.getAbbrev().equals("P")) || doctype.getAbbrev().equals("BC")) {

                    %>
                    <div class="col-lg-7" style="/*margin-right: 30px;*/">
                        <table class="table" id="tab_logic_total" >
                            <tbody> 
                                <tr>
                                    <th class="text-left" style="width: 50%;    padding-top: 25px;">Sous-total</th>
                                    <td class="text-center">
                                        <div class="col-lg-12">
                                            <input style="background: #00000000;border-color: transparent;height: 10px;" class="effect-4 text-right " type="number" name='sub_total' placeholder='0.00' id="sub_total" readonly/>
                                            <span class="focus-border"></span>
                                        </div>
                                    </td>
                                </tr>
                                <tr>
                                    <th class="text-left" style="width: 50%;    padding-top: 25px;">Taxe</th>
                                    <td class="text-center">
                                        <div class="col-lg-12">
                                            <div class="input-group mb-2 mb-sm-0">

                                                <input style="background: #00000000;border-color: transparent;height: 10px;" class="effect-4 text-right" type="number" id="tax" placeholder="0" value="19">
                                                <span class="focus-border"></span>

                                                <div class="input-group-addon" style="background:transparent;border-color:transparent;">%</div>
                                            </div>
                                        </div>
                                    </td>
                                </tr>
                                <tr>
                                    <th class="text-left" style="width: 50%;    padding-top: 25px;">Montant du taxe</th>
                                    <td class="text-center">
                                        <div class="col-lg-12">
                                            <input style="background: #00000000;border-color: transparent;height: 10px;" class="effect-4 text-right" type="number" name='tax_amount' id="tax_amount" placeholder='0.00' />
                                            <span class="focus-border"></span>
                                        </div>
                                    </td>
                                </tr>
                                <tr>
                                    <th class="text-left" style="width: 50%;    padding-top: 25px;">Remise</th>
                                    <td class="text-center">
                                        <div class="col-lg-12">
                                            <div class="input-group mb-2 mb-sm-0">

                                                <input style="background: #00000000;border-color: transparent;height: 10px;" class="effect-4 text-right" type="number" id="remise" placeholder="0" value="0">
                                                <span class="focus-border"></span>

                                                <div class="input-group-addon" style="background:transparent;border-color:transparent;">%</div>
                                            </div>
                                        </div>
                                    </td>
                                </tr>
                                <tr>
                                    <th class="text-left" style="width: 50%;    padding-top: 25px;">Montant de remise</th>
                                    <td class="text-center">
                                        <div class="col-lg-12">
                                            <input style="background: #00000000;border-color: transparent;height: 10px;" class="effect-4 text-right" type="number" name='remise_amount' id="remise_amount" placeholder='0.00' value="0" />
                                            <span class="focus-border"></span>
                                        </div>
                                    </td>
                                </tr>
                                <%                                    if (doctype.getAbbrev().equals("O") || doctype.getAbbrev().equals("Fac")) {
                                %>
                                <tr>
                                    <th class="text-left" style="width: 50%;    padding-top: 25px;">Timbre 1%</th>
                                    <td class="text-center">
                                        <div class="col-lg-12">
                                            <input style="background: #00000000;border-color: transparent;height: 10px;" class="effect-4 text-right" type="number" name='timbre_amount' id="timbre_amount" placeholder='0.00' value="0" />
                                            <span class="focus-border"></span>
                                        </div>
                                    </td>
                                </tr>
                                <%
                                    }
                                %>
                                <tr>
                                    <th class="text-left" style="width: 50%;    padding-top: 25px;">Total général</th>
                                    <td class="text-right">
                                        <div class="col-lg-12">
                                            <input style="background: #00000000;border-color: transparent;height: 10px;" class="effect-4 text-right" type="number" name='total_amount' id="total_amount" placeholder='0.00' readonly/>
                                            <span class="focus-border"></span>
                                        </div>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                    <%
                        }
                    %>
                </div>
            </div>
        </div>
    </div>
</fieldset>
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<link rel="stylesheet" href="/resources/demos/style.css">
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script>

    $(function () {


        /*var modeL = new Array();
         modeL = ["None", "sur site client"];
         var modeR = new Array();
         modeR = ["None", "à terme", "Versement", "Espèce"];
         
         $("#modeL").autocomplete({
         source: modeL
         });
         $("#modeR").autocomplete({
         source: modeR
         });*/

        //modeRmodeLdelaislvaliditeo
        $("#closesnModal").click(function () {
            $("#qtymodal").attr("data-target", "");

        });
        $("#cancelsnModal").click(function () {
            $("#qtymodal").attr("data-target", "");
        });
        $("#confirmsnModal").click(function () {
            $("#qtymodal").attr("data-target", "");
            $("#snModal").hide();

        });
        $("#qtymodal").click(function () {
            $("#qtymodal").attr("data-target", "#snModal");
            //data-target="#exampleModal"
            //alert("ok");
            //$(this).removeAttr("data-target");
            /*if ($("#typearticle").val() == "" || $("#productarticle").val() == "") {
             $("#qtymodal").attr("data-target", "");
             } else {
             $.ajax({
             url: '/IMTRADE/Controle_saisie',
             method: "POST",
             data: {
             type: $("#typearticle").val(),
             product: $("#productarticle").val(),
             article: "typeproductarticle"
             },
             success: function (data) {
             if (data == "yes") {
             $("#qtymodal").attr("data-target", "#snModal");
             } else {
             $("#qtymodal").attr("data-target", "");
             }
             //alert(data);
             }
             });
             }*/

        });



        /*
         var type = new Array();
         
         var product = new Array();
         
         $("#typearticle").on("change paste keyup", function () {
         $.ajax({
         url: '/IMTRADE/Controle_saisie',
         method: "POST",
         data: {
         param: $(this).val(),
         article: "typearticle"
         },
         success: function (data) {
         var p = data.split("%%");
         if (p[0].length > 0) {
         $("#productarticle").val("");
         product = p;
         $("#productarticle").autocomplete({
         source: product
         });
         }
         
         }
         });
         });
         
         $("#productarticle").bind("change paste keyup", function () {
         //if ($("#productarticle").val() != "") {
         $.ajax({
         url: '/IMTRADE/Controle_saisie',
         method: "POST",
         data: {
         param: $(this).val(),
         article: "productarticle"
         },
         success: function (data) {
         var res = data.split("%%");
         if (res[0].length > 0) {
         $("#typearticle").val(res[0]);
         $("#pricearticle").val(res[1]);
         $("#qtyarticle").val(0);
         }
         
         
         }
         });
         //}
         
         });
         
         
         
         $("#productarticle").autocomplete({
         source: product
         });
         
         $("#typearticle").autocomplete({
         source: type
         });*/





    });
</script>