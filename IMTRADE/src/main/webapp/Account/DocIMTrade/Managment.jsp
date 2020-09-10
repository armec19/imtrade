<%@page import="maps.Structure"%>
<%@page import="maps.StructureDetails"%>
<div id="prive">
    <%
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
    %>

    <div class="row page-titles">
        <div class="col-md-5 align-self-center">
            <h4 class="text-themecolor">Propriétaire</h4>
        </div>
        <div class="col-md-7 align-self-center text-right">
            <div class="d-flex justify-content-end align-items-center">
                <ol class="breadcrumb">
                    <li class="breadcrumb-item"><a href="javascript:void(0)">Document IMTrade</a></li>
                    <li class="breadcrumb-item active">Propriétaire</li>
                </ol> 
            </div>
        </div>
    </div>
    <div class="row">
        <div class="col-lg-12">
            <div class="card">
                <div class="card-body">
                    <!---->
                    <ul class="nav nav-pills m-t-30 justify-content-end m-b-30">

                        <li class=" nav-item"> <a href="#entete" class="nav-link active" data-toggle="tab" aria-expanded="false">Renseignements</a> </li>
                        <li class="nav-item"> <a href="#Projets" id="btnProjets" class="nav-link" data-toggle="tab" aria-expanded="true">Projets</a> </li>
                        <li class="nav-item"> <a href="#Natures" class="nav-link" data-toggle="tab" aria-expanded="true">Natures</a> </li>
                        <li class="nav-item"> <a href="#Types" class="nav-link" data-toggle="tab" aria-expanded="true">Types</a> </li>
                        <li class="nav-item"> <a href="#Designations" class="nav-link" data-toggle="tab" aria-expanded="true">Designations</a> </li>
                        <li class="nav-item"> <a href="#Fournisseurs" class="nav-link" data-toggle="tab" aria-expanded="true">Destinateurs</a> </li>
                        <li class="nav-item"> <a href="#Articles" class="nav-link" data-toggle="tab" aria-expanded="true">Articles</a> </li>
                        <li class="nav-item"> <a href="#documents" class="nav-link" data-toggle="tab" aria-expanded="true">Type des documents</a> </li>
                        <li class="nav-item"> <a href="#reglement" class="nav-link" data-toggle="tab" aria-expanded="true">Réglement</a> </li>
                        <li class="nav-item"> <a href="#livraison" class="nav-link" data-toggle="tab" aria-expanded="true">Livraison</a> </li>
                    </ul>
                    <div class="tab-content br-n pn">
                        <div id="entete" class="tab-pane active">
                            <div class="container">
                                <h4 class="card-title" style="border-bottom: 1px solid rgba(0,0,0,.1);padding-bottom: 10px;">Les renseignements</h4>
                                <form class="row" id="#corrd">
                                    <div class="form-group col-md-3">
                                        <label for="txt1">Structure</label>
                                        <input type="email" class="form-control" id="txt1" aria-describedby="emailHelp"  disabled="disabled" value="<%= structure.getNomStructure()%>">
                                    </div>
                                    <div class="form-group col-md-3">
                                        <label for="txt2">Capital</label>
                                        <input type="text" class="form-control" id="txt2" aria-describedby="emailHelp" placeholder="Enter un capital" value="<%= entete_capital%>">
                                    </div>
                                    <div class="form-group col-md-3">
                                        <label for="txt3">Adresse</label>
                                        <input type="text" class="form-control" id="txt3" aria-describedby="emailHelp" placeholder="Enter l'adresse" value="<%= entete_adr%>" >
                                    </div>
                                    <div class="form-group col-md-3">
                                        <label for="txt4">Registre de commerce</label>
                                        <input type="text" class="form-control" id="txt4" aria-describedby="emailHelp" placeholder="Enter le registre de commerce" value="<%= entete_rc%>" >
                                    </div>
                                    <div class="form-group col-md-3">
                                        <label for="txt5">N.I.F</label>
                                        <input type="text" class="form-control" id="txt5" aria-describedby="emailHelp" placeholder="Enter N.I.F" value="<%= entete_nif%>" >
                                    </div>
                                    <div class="form-group col-md-3">
                                        <label for="txt6">N.I.S</label>
                                        <input type="text" class="form-control" id="txt6" aria-describedby="emailHelp" placeholder="Enter N.I.S" value="<%= entete_nis%>" >
                                    </div>
                                    <div class="form-group col-md-3">
                                        <label for="txt7">A.R.T</label>
                                        <input type="text" class="form-control" id="txt7" aria-describedby="emailHelp" placeholder="Enter A.R.T" value="<%= entete_art%>" >
                                    </div>
                                    <div class="form-group col-md-3">
                                        <label for="txt8">RIB</label>
                                        <input type="text" class="form-control" id="txt8" aria-describedby="emailHelp" placeholder="Enter RIB" value="<%= entete_rib%>" >
                                    </div>
                                    <div class="form-group text-right col-md-3">
                                        <label for="btn00" style="color: transparent;">.</label>
                                        <button id="btn00" type="button" style="font-size: 16px;" class="btn btn-block btn-outline-info waves-effect waves-light">Editer</button>
                                    </div>
                                    <div class="form-group col-md-3">
                                        <label for="txt9">Banque</label>
                                        <input type="text" class="form-control" id="txt9" aria-describedby="emailHelp" placeholder="Enter la banque" value="<%= entete_banque%>" >
                                    </div>
                                    <div class="form-group col-md-3">
                                        <label for="txt10">Site</label>
                                        <input type="text" class="form-control" id="txt10" aria-describedby="emailHelp" placeholder="Enter un site" value="<%= entete_site%>" >
                                    </div>
                                    <div class="form-group col-md-3">
                                        <label for="txt11">Contact (Tel/Fax)</label>
                                        <input type="text" class="form-control" id="txt11" aria-describedby="emailHelp" placeholder="Enter tel et/ou fax" value="<%= entete_contact%>" >
                                    </div>


                                </form>
                            </div>
                        </div>
                        <div id="Projets" class="tab-pane">
                            <div class="container">
                                <h4 class="card-title">Projets</h4>
                                <%
                                    request.setAttribute("tablemanage", "Projet");
                                    
                                %>
                                <jsp:include page="../Model/tablemodal.jsp" />
                            </div>
                        </div>
                        <div id="Natures" class="tab-pane ">
                            <div class="container">
                                <h4 class="card-title">Natures</h4>
                                <%
                                    request.setAttribute("tablemanage", "Nature");
                                %>
                                <jsp:include page="../Model/tablemodal.jsp" />
                            </div>
                        </div>
                        <div id="Types" class="tab-pane ">
                            <div class="container">
                                <h4 class="card-title">Types</h4>
                                <%
                                    request.setAttribute("tablemanage", "TypeNature");
                                %>
                                <jsp:include page="../Model/tablemodal.jsp" />
                            </div>
                        </div>
                        <div id="Designations" class="tab-pane ">
                            <div class="container">
                                <h4 class="card-title">Designations</h4>
                                <%
                                    request.setAttribute("tablemanage", "DesignationNature");
                                %>
                                <jsp:include page="../Model/tablemodal.jsp" />
                            </div>
                        </div>
                        <div id="Fournisseurs" class="tab-pane ">
                            <div class="container">
                                <h4 class="card-title">Destinateurs</h4>
                                <%
                                    request.setAttribute("tablemanage", "Destinateur");
                                %>
                                <jsp:include page="../Model/tablemodal.jsp" />
                            </div>
                        </div>
                        <div id="Articles" class="tab-pane ">
                            <div class="container">
                                <h4 class="card-title">Articles</h4>
                                <%
                                    request.setAttribute("tablemanage", "Produit");
                                %>
                                <jsp:include page="../Model/tablemodal.jsp" />
                            </div>
                        </div>
                        <div id="documents" class="tab-pane ">
                            <div class="container">
                                <h4 class="card-title">Type d'attachment</h4>
                                <%
                                    request.setAttribute("tablemanage", "TypeAttachment");
                                %>
                                <jsp:include page="../Model/tablemodal.jsp" />
                            </div>
                        </div>
                        <div id="reglement" class="tab-pane ">
                            <div class="container">
                                <h4 class="card-title">Mode de réglement</h4>
                                <%
                                    request.setAttribute("tablemanage", "ModeReglement");
                                %>
                                <jsp:include page="../Model/tablemodal.jsp" />
                            </div>
                        </div>
                        <div id="livraison" class="tab-pane ">
                            <div class="container">
                                <h4 class="card-title">Mode de livraison</h4>
                                <%
                                    request.setAttribute("tablemanage", "ModeLivraison");
                                %>
                                <jsp:include page="../Model/tablemodal.jsp" />
                            </div>
                        </div>

                    </div>

                </div>
            </div>
        </div>
    </div>

    <script src="../../assets/node_modules/raphael/raphael-min.js"></script>
    <script src="../../assets/node_modules/morrisjs/morris.min.js"></script>
    <script src="../../assets/node_modules/jquery-sparkline/jquery.sparkline.min.js"></script>

    <!-- Popup message jquery -->
    <script src="../../assets/node_modules/toast-master/js/jquery.toast.js"></script>
    <script src="../../assets/node_modules/sticky-kit-master/dist/sticky-kit.min.js"></script>
    <script src="../../assets/node_modules/sparkline/jquery.sparkline.min.js"></script>

    <script>
        // This is for the sticky sidebar 

        /*$(".nav-pills .nav-link.active, .nav-pills .show > .nav-link a").on("click", function () {
         //$('.nav-pills .nav-link.active, .nav-pills .show > .nav-link a').click(function () {
         alert("ok"); 
         });*/
        $(".stickyside").stick_in_parent({
            offset_top: 100
        });
        $('.stickyside a').click(function () {
            $('html, body').animate({
                scrollTop: $($(this).attr('href')).offset().top - 100
            }, 500);
            return false;
        });
        // This is auto select left sidebar
        // Cache selectors
        // Cache selectors
        var lastId,
                topMenu = $(".stickyside"),
                topMenuHeight = topMenu.outerHeight(),
                // All list items
                menuItems = topMenu.find("a"),
                // Anchors corresponding to menu items
                scrollItems = menuItems.map(function () {
                    var item = $($(this).attr("href"));
                    if (item.length) {
                        return item;
                    }
                    //alert(menuItems);
                });

        // Bind click handler to menu items


        // Bind to scroll
        $(window).scroll(function () {
            // Get container scroll position
            var fromTop = $(this).scrollTop() + topMenuHeight - 250;

            // Get id of current scroll item
            var cur = scrollItems.map(function () {
                if ($(this).offset().top < fromTop)
                    return this;
            });
            // Get the id of the current element
            cur = cur[cur.length - 1];
            var id = cur && cur.length ? cur[0].id : "";

            if (lastId !== id) {
                lastId = id;
                // Set/remove active class
                menuItems
                        .removeClass("active")
                        .filter("[href='#" + id + "']").addClass("active");
            }
        });

       
    </script>
</div>                    

