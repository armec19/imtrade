<%-- 
    Document   : index
    Created on : 30 juin 2020, 08:42:38
    Author     : Mechri
--%>
<%@page import="module.ModelBean"%>
<%@page import="maps.Serialnumber"%>
<%@page import="maps.Structure"%>
<%@page import="java.util.List"%>
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
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    if (session.getAttribute("Utilisateur") == null) {
        response.sendRedirect("../../login.jsp");
    } else {
        Utilisateur utilisateur = (Utilisateur) session.getAttribute("Utilisateur");
        Membre membre = (Membre) session.getAttribute("Membre");
        Structure structure = (Structure) session.getAttribute("Structure");
        StructureDetails structureDetails = (StructureDetails) session.getAttribute("StructureDetails");
        TemplateDocument templateDocument = null;
        Document document = null;
        ArrayList<Objet> doccontents = new ArrayList<Objet>();
        if (session.getAttribute("TemplateDocument") != null) {
            templateDocument = (TemplateDocument) session.getAttribute("TemplateDocument");
        } else {
            session.setAttribute("New", "true");
        }

        if (session.getAttribute("docimtrade") != null) {
            document = (Document) session.getAttribute("docimtrade");
            doccontents = (ArrayList<Objet>) session.getAttribute("doccontents");
            ((HashMap<String, String>) session.getAttribute("hashMap")).replace("projet", "" + document.getIdProjet());
            ((HashMap<String, String>) session.getAttribute("hashMap")).replace("nature", "" + document.getIdNature());
            ((HashMap<String, String>) session.getAttribute("hashMap")).replace("type", "" + document.getIdType());
            ((HashMap<String, String>) session.getAttribute("hashMap")).replace("designation", "" + document.getIdDesignation());
            ((HashMap<String, String>) session.getAttribute("hashMap")).replace("destinateurid", "" + document.getIdDestinataire());
        }
        Doctype doctype = (Doctype) session.getAttribute("Doctype");

        if (session.getAttribute("islocked") == "true") {
            response.sendRedirect("../../lock.jsp");
        } else {
            if (session.getAttribute("pagename") == null) {
                response.sendRedirect("../index.jsp");
            } else {


%>
<jsp:include page="/Content" />
<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <!-- Tell the browser to be responsive to screen width -->
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <meta name="description" content="">
        <meta name="author" content="">
        <!-- Favicon icon -->
        <link rel="icon" type="image/png" sizes="16x16" href="../../dist/favicon.ico">
        <title><%= doctype.getNomDocument()%></title>

        <link rel="stylesheet" href="../../assets/node_modules/morrisjs/morris.css">
        <!--Toaster Popup message CSS -->
        <link rel="stylesheet" href="../../assets/node_modules/toast-master/css/jquery.toast.css">
        <link href="../../assets/node_modules/typeahead.js-master/dist/typehead-min.css" rel="stylesheet">
        <!-- Custom CSS -->
        <link rel="stylesheet" href="../../dist/css/form/font-awesome.min.css">
        <link rel="stylesheet" href="../../dist/css/form/font-awesome.min.css">
        <link rel="stylesheet" href="../../dist/css/form/font-awesome.css">

        <link href="../../dist/css/pages/stylish-tooltip1.css" rel="stylesheet">
        <link rel="stylesheet" href="../../dist/css/style.min.css">
        <!-- Dashboard 1 Page CSS -->
        <link rel="stylesheet" href="../../dist/css/pages/dashboard1.css">
        <link rel="stylesheet" type="text/css"
              href="../../assets/node_modules/datatables.net-bs4/css/dataTables.bootstrap4.css">
        <link rel="stylesheet" type="text/css"
              href="../../assets/node_modules/datatables.net-bs4/css/responsive.dataTables.min.css">
        <link href="../../assets/node_modules/sweetalert2/dist/sweetalert2.min.css" rel="stylesheet">
        <link href="../../assets/node_modules/switchery/dist/switchery.min.css" rel="stylesheet" />
        <style>
            .sidebar-nav ul li a:hover{
                text-decoration: none;
            }
            .page-titles .breadcrumb li a:hover{
                text-decoration: none;
            }
            h33:hover{
                text-decoration: none;
            }
            a:hover{
                text-decoration: none;
            }
        </style>
    </head>

    <body class="fixed-layout skin-megna mini-sidebar">

        <div class="preloader">
            <div class="loader">
                <div class="loader__figure"></div>
                <p class="loader__label">IMANAGE</p>
            </div>
        </div>


        <div id="main-wrapper">

            <header class="topbar">
                <nav class="navbar top-navbar navbar-expand-md navbar-dark">

                    <div class="navbar-header">
                        <a class="navbar-brand" href="index.html">
                            <b>

                                <!--<img src="../../assets/images/logo-icon.png" alt="homepage" class="dark-logo" />-->
                                <!-- Light Logo icon -->
                                <!--<img src="../../assets/images/logo-light-icon.png" alt="homepage" class="light-logo" />-->
                            </b>
                            <span>
                                <!-- dark Logo text -->
                                <!--<img src="../../assets/images/logo-text.png" alt="homepage" class="dark-logo" />-->
                                <!-- Light Logo text -->    
                                <!--<img src="../../assets/images/logo-light-text.png" class="light-logo" alt="homepage" /></span> </a>-->
                                </div>

                                <div class="navbar-collapse">

                                    <ul class="navbar-nav mr-auto">
                                        <!-- This is  -->
                                        <li class="nav-item"> <a class="nav-link nav-toggler d-block d-md-none waves-effect waves-dark" href="javascript:void(0)"><i class="ti-menu"></i></a> </li>
                                        <li class="nav-item"> <a class="nav-link sidebartoggler d-none d-lg-block d-md-block waves-effect waves-dark" href="javascript:void(0)"><i class="icon-menu"></i></a> </li>

                                        <li class="nav-item">
                                            <form class="app-search d-none d-md-block d-lg-block">
                                                <input type="text" class="form-control" placeholder="Rechercher">
                                            </form>
                                        </li>
                                    </ul>


                                </div>
                                </nav>
                                </header>

                                <aside class="left-sidebar">
                                    <!-- Sidebar scroll-->
                                    <div class="scroll-sidebar">
                                        <!-- Sidebar navigation-->
                                        <nav class="sidebar-nav">
                                            <ul id="sidebarnav">
                                                <li class="user-pro"> <a class="has-arrow waves-effect waves-dark" href="javascript:void(0)" aria-expanded="false"><img src="../../assets/images/users/1.jpg" alt="user-img" class="img-circle"><span class="hide-menu"><%= membre.getNom()%></span></a>
                                                    <ul aria-expanded="false" class="collapse">
                                                        <li><a href="javascript:void(0)"><i class="ti-user"></i> Mon Profil</a></li>
                                                        <li><a href="javascript:void(0)"><i class="ti-email"></i> e-Mails</a></li>
                                                        <li><a href="javascript:void(0)"><i class="ti-bell"></i> Notifications</a></li>
                                                        <li><a href="javascript:void(0)"><i class="ti-settings"></i> Paramétrage</a></li>
                                                        <li><a href="javascript:void(0)"><i class="ti-lock"></i> Verrouiller</a></li>
                                                        <li><a href="javascript:void(0)"><i class="fa fa-power-off"></i> Se déconnecter</a></li>
                                                    </ul>
                                                </li>
                                                <li class="nav-small-cap">--- <%= doctype.getNomDocument()%></li>

                                                <%
                                                    if (session.getAttribute("docimtrade") == null) {
                                                %>
                                                <li> 
                                                    <a class="waves-effect waves-dark menu confirmed" href="javascript:void(0)" aria-expanded="false"><i class="ti-save"></i><span class="hide-menu">Creation</span></span></a>      
                                                </li>
                                                <li> 
                                                    <a class="waves-effect waves-dark menu templated" href="javascript:void(0)" aria-expanded="false"><i class="ti-bookmark-alt"></i><span class="hide-menu">Etablir un modèle</span></span></a>      
                                                </li>
                                                <%
                                                } else {
                                                %>
                                                <%
                                                    if (document.getDocumentEtat().equals("validated")) {
                                                %>        
                                                <li> 
                                                    <a class="waves-effect waves-dark menu confirmed" href="javascript:void(0)" aria-expanded="false"><i class="ti-save"></i><span class="hide-menu">Confirmation</span></span></a>      
                                                </li>
                                                <li> 
                                                    <a class="waves-effect waves-dark menu templated" href="javascript:void(0)" aria-expanded="false"><i class="ti-bookmark-alt"></i><span class="hide-menu">Etablir un modèle</span></span></a>      
                                                </li>
                                                <%
                                                    }
                                                %>
                                                <%
                                                    if (document.getDocumentEtat().equals("templated")) {
                                                %>        
                                                <li> 
                                                    <a class="waves-effect waves-dark menu created" href="javascript:void(0)" aria-expanded="false"><i class="ti-save"></i><span class="hide-menu">Creation</span></span></a>      
                                                </li>
                                                <li> 
                                                    <a class="waves-effect waves-dark menu templated" href="javascript:void(0)" aria-expanded="false"><i class="ti-bookmark-alt"></i><span class="hide-menu">Annuler modèle</span></span></a>      
                                                </li>
                                                <%
                                                    }
                                                    if (document.getDocumentEtat().equals("created")) {
                                                %>
                                                <li> 
                                                    <a class="waves-effect waves-dark menu templated" href="javascript:void(0)" aria-expanded="false"><i class="ti-bookmark-alt"></i><span class="hide-menu">Etablir un modèle</span></span></a>      
                                                </li>
                                                <%
                                                        }
                                                    }
                                                %>
                                                <li> 
                                                    <a class="waves-effect waves-dark menu" href="javascript:void(0)" aria-expanded="false"><i class="ti-fullscreen"></i><span class="hide-menu">Pleine page</span></span></a>      
                                                </li>
                                                <li> 
                                                    <a class="waves-effect waves-dark menu" href="javascript:void(0)" aria-expanded="false"><i class="ti-back-left"></i><span class="hide-menu">Revenir</span></span></a>
                                                </li>
                                        </nav>
                                        <!-- End Sidebar navigation -->
                                    </div>
                                    <!-- End Sidebar scroll-->
                                </aside>

                                <div class="page-wrapper">

                                    <div class="container-fluid">



                                        <div id="body_content">
                                            <jsp:include page="file.jsp" />
                                        </div>
                                        <div class="modal" id="snModal" tabindex="-1" role="dialog" aria-labelledby="snModalLable">
                                            <div class="modal-dialog" role="document">
                                                <div class="modal-content">
                                                    <div class="modal-header">
                                                        <h4 class="modal-title" id="snModalLable">Quantité</h4>
                                                        <button type="button" id="closesnModal" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                                                    </div>
                                                    <div class="/*modal-body*/">

                                                        <ul class="nav nav-tabs customtab" role="tablist">
                                                            <li class="nav-item" style="width: 50%;text-align: center;"> <a class="nav-link active" data-toggle="tab" href="#home2" role="tab"><span class="hidden-sm-up"><i class="ti-layout-tab-v"></i></span> <span class="hidden-xs-down">Scanner</span></a> </li>
                                                                        <%
                                                                            if (!doctype.getAbbrev().equals("BE")) {
                                                                        %>
                                                            <li class="nav-item" style="width: 50%;text-align: center;"> <a class="nav-link" data-toggle="tab" href="#profile2" role="tab"><span class="hidden-sm-up"><i class="ti-check-box"></i></span> <span class="hidden-xs-down">Selectionner</span></a> </li>
                                                                        <%
                                                                            }
                                                                        %>
                                                        </ul>

                                                        <div class="tab-content">
                                                            <div class="tab-pane active" id="home2" role="tabpanel">
                                                                <form>
                                                                    <div style="width: auto;">
                                                                        <input type="checkbox" name="agree-term"  id="auto-add" class="agree-term" />
                                                                        <label for="auto-add" class="label-agree-term col-md-8"><span><span></span></span>Ajout automatique</label>
                                                                        <input style="font-size: 13px;background: #00000000;border-color: transparent;" autofocus type="text" name='qtesn' id='qtesn' placeholder='Qté' class="effect-4 text-left col-md-4">
                                                                    </div>
                                                                    <main id="table" class="col-md-12" style="height: 300px;overflow-y: auto;margin-right: 15px;">

                                                                        <table class="table" id="tab_logic_SN">
                                                                            <thead>
                                                                                <tr style="color:white;">

                                                                                    <th class="col-md-12 th text-left">Numéros de série</th>

                                                                                    <th class="th text-center">#</th>
                                                                                </tr>
                                                                            </thead>
                                                                            <tbody>

                                                                                <tr id='tab_logic_SNaddr0' class="tab_logic_SNfirst-tr">

                                                                                    <td class="static">
                                                                                        <input style="font-size: 13px;padding: 0px;background: #00000000;border-color: transparent;" autofocus type="text" name='sn' id='sn' placeholder='SN...' class="effect-4 text-left sn">
                                                                                    </td>

                                                                                    <td class="static"><button type="button" style="margin-top: 10px;border-radius: 20px;" class="button green_SN"><i class="glyphicon glyphicon-plus" style="font-size: 25px;font-weight: bold;"></i></button></td>
                                                                                </tr>

                                                                            </tbody>
                                                                        </table>
                                                                        <div class="alert_SN">
                                                                            <h2>Erreur !</h2>
                                                                            <p id="texterror_SN"></p>
                                                                            <input type="button" style="width: auto;margin-bottom: 10px;" value="Retour" class="btn btn-danger center-block button remove_SN"> 
                                                                        </div>
                                                                    </main>
                                                                </form>
                                                            </div>
                                                            <%
                                                                if (!doctype.getAbbrev().equals("BE")) {
                                                            %>
                                                            <div class="tab-pane " id="profile2" role="tabpanel">
                                                                <div class="table-responsive">

                                                                    <table id="SNTable" class="table table-bordered table-striped">
                                                                        <thead>
                                                                            <tr >
                                                                                <th>Numéros de série</th>
                                                                            </tr>
                                                                        </thead>
                                                                        <tbody>
                                                                            <%                                                                                List<Serialnumber> serialnumber = (List<Serialnumber>) ModelBean.GetContentTable("Serialnumber", "where isdeleted=0");
                                                                                for (int idx = 0; idx < serialnumber.size(); idx++) {
                                                                                    Serialnumber elem = serialnumber.get(idx);

                                                                            %>
                                                                            <tr for="a1">
                                                                                <td style="padding: 0px;padding-left:5px;">
                                                                                    <input class="col-lg-1" type="checkbox" id="<%= elem.getSn()%>" style="width: 17px;display: block;">
                                                                                    <label class="col-lg-11" for="<%= elem.getSn()%>" style="margin-top: 15px;font-size: 15px;font-weight: normal;"><%= elem.getSn()%></label>
                                                                                </td>
                                                                            </tr>
                                                                            <%
                                                                                }
                                                                            %>

                                                                        </tbody>
                                                                    </table>
                                                                </div>

                                                            </div>
                                                            <%
                                                                }
                                                            %>                
                                                        </div>

                                                    </div>
                                                    <div class="modal-footer">
                                                        <button type="button" id="cancelsnModal" class="btn btn-outline-secondary waves-effect waves-light" data-dismiss="modal">Retourne</button>
                                                        <button type="button" id="confirmsnModal"  class="btn btn-outline-info waves-effect waves-light" data-dismiss="modal">Confirmer</button>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="right-sidebar">
                                            <div class="slimscrollright">
                                                <div class="rpanel-title"> Parametrage <span><i class="ti-close right-side-toggle"></i></span> </div>
                                                <div class="r-panel-body">
                                                    <ul id="themecolors" class="m-t-20">
                                                        <li><b>Avec la barre light</b></li>
                                                        <li><a href="javascript:void(0)" data-skin="skin-default" class="default-theme working">1</a></li>
                                                        <li><a href="javascript:void(0)" data-skin="skin-green" class="green-theme">2</a></li>
                                                        <li><a href="javascript:void(0)" data-skin="skin-red" class="red-theme">3</a></li>
                                                        <li><a href="javascript:void(0)" data-skin="skin-blue" class="blue-theme">4</a></li>
                                                        <li><a href="javascript:void(0)" data-skin="skin-purple" class="purple-theme">5</a></li>
                                                        <li><a href="javascript:void(0)" data-skin="skin-megna" class="megna-theme">6</a></li>
                                                        <li class="d-block m-t-30"><b>Avec la barre noir</b></li>
                                                        <li><a href="javascript:void(0)" data-skin="skin-default-dark" class="default-dark-theme ">7</a></li>
                                                        <li><a href="javascript:void(0)" data-skin="skin-green-dark" class="green-dark-theme">8</a></li>
                                                        <li><a href="javascript:void(0)" data-skin="skin-red-dark" class="red-dark-theme">9</a></li>
                                                        <li><a href="javascript:void(0)" data-skin="skin-blue-dark" class="blue-dark-theme">10</a></li>
                                                        <li><a href="javascript:void(0)" data-skin="skin-purple-dark" class="purple-dark-theme">11</a></li>
                                                        <li><a href="javascript:void(0)" data-skin="skin-megna-dark" class="megna-dark-theme ">12</a></li>
                                                    </ul>

                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>



                                <footer class="footer">
                                    © 2020 IMTRADE
                                </footer>

                                </div>


                                <!-- Modal -->


                                <script src="../../assets/node_modules/popper/popper.min.js"></script>
                                <script src="../../assets/node_modules/bootstrap/dist/js/bootstrap.min.js"></script>
                                <!-- slimscrollbar scrollbar JavaScript -->
                                <script src="../../dist/js/perfect-scrollbar.jquery.min.js"></script>
                                <!--Wave Effects -->
                                <script src="../../dist/js/waves.js"></script>
                                <!--Menu sidebar -->
                                <script src="../../dist/js/sidebarmenu.js"></script>
                                <!--Custom JavaScript -->
                                <script src="../../dist/js/custom.min.js"></script>

                                <script src="../../assets/node_modules/raphael/raphael-min.js"></script>
                                <script src="../../assets/node_modules/morrisjs/morris.min.js"></script>
                                <script src="../../assets/node_modules/jquery-sparkline/jquery.sparkline.min.js"></script>

                                <!-- Popup message jquery -->
                                <script src="../../assets/node_modules/toast-master/js/jquery.toast.js"></script>
                                <script src="../../assets/node_modules/sticky-kit-master/dist/sticky-kit.min.js"></script>
                                <script src="../../assets/node_modules/sparkline/jquery.sparkline.min.js"></script>

                                <script src="PDF/examples/js/ace.js" type="text/javascript" charset="utf-8"></script>

                                <script src='https://cdnjs.cloudflare.com/ajax/libs/vue/2.1.10/vue.min.js'></script>
                                <script src="../../assets/node_modules/datatables.net/js/jquery.dataTables.min.js"></script>
                                <script src="../../assets/node_modules/datatables.net-bs4/js/dataTables.responsive.min.js"></script>
                                <script src="../../assets/node_modules/sweetalert2/dist/sweetalert2.all.min.js"></script>
                                <script src="../../assets/node_modules/sweetalert2/sweet-alert.init.js"></script>
                                <script src="../../assets/node_modules/typeahead.js-master/dist/typeahead.bundle.min.js"></script>
                                <script src="../../assets/node_modules/switchery/dist/switchery.min.js"></script>
                                <!--<script src="../../assets/node_modules/typeahead.js-master/typeahead2.init.js"></script>-->
                                <jsp:include page="../../assets/node_modules/typeahead.js-master/typeahead.jsp" />
                                <script type="text/javascript" src="PDF/dist/jspdf.debug.js"></script>		
                                <script src="PDF/libs/faker.min.js"></script>
                                <script src="PDF/libs/jspdf.plugin.autotable.js"></script>
                                <script type="text/javascript" src="PDF/examples/js/pdfobject.min.js"></script>
                                <script type="text/javascript" src="PDF/examples/js/editor.js"></script>


                                <script>
                                    // This is for the sticky sidebar    
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

                                <script>

                                    $(document).ready(function () {
                                        //bar-left
                                        $("#creermodele").click(function () {
                                            //#modelenom
                                            if ($("#modelenom").val() == "") {
                                                Swal.fire({
                                                    title: "Rectification",
                                                    text: "Inserer un nom template",
                                                    timer: 2000,
                                                    showConfirmButton: false
                                                });
                                            } else {
                                                $.ajax({
                                                    url: '/IMTRADE/Content',
                                                    method: "POST",
                                                    data: {
                                                        fonction: "createmodele"
                                                    },
                                                    success: function (data) {
                                                        //Swal.fire("Creation", "Cette modele a été créée avec succée", "success")
                                                        Swal.fire({
                                                            position: 'center',
                                                            type: 'success',
                                                            title: 'la template est créée',
                                                            showConfirmButton: false,
                                                            timer: 1500
                                                        })

                                                    }
                                                });
                                            }
                                        });
                                        $("a.menu").click(function () {
                                            const swalWithBootstrapButtons = Swal.mixin({
                                                customClass: {
                                                    confirmButton: 'btn btn-success waves-effect waves-light',
                                                    cancelButton: 'mr-2 btn btn-danger waves-effect waves-light'
                                                },
                                                buttonsStyling: false,
                                            });

                                            switch ($(".skin-megna .sidebar-nav ul li a.active .hide-menu").text()) {
                                                case "Revenir":
                                                    window.open('../index.jsp', '_self');
                                                    break;
                                                case "Pleine page":
                                                    window.open('pdf.jsp', '_blank');
                                                    break;
                                                case "Etablir un modèle":
                                                    Swal.mixin({
                                                        input: 'text',
                                                        //confirmButtonText: 'Confirmer &rarr;',
                                                        confirmButtonText: 'Confirmer',
                                                        showCancelButton: true,
                                                        cancelButtonText: 'No, annuler!'
                                                                //progressSteps: ['1']
                                                    }).queue([
                                                        {
                                                            title: 'Creation',
                                                            text: 'Inserer un nom de template'
                                                        }
                                                    ]).then((result) => {
                                                        var vv = JSON.stringify(result.value);
                                                        //alert(vv.length);
                                                        if (vv.length == 4) {
                                                            /*Swal.fire({
                                                             title: 'Creation!',
                                                             /*html: 'Your answers: <pre><code>' +
                                                             JSON.stringify(result.value) +
                                                             '</code></pre>',
                                                             confirmButtonText: 'Creation!'
                                                             })*/
                                                            /*Swal.fire({
                                                             position: 'center',
                                                             type: 'error',
                                                             title: 'Inserer un nom de template',
                                                             showConfirmButton: false,
                                                             timer: 1500
                                                             });*/
                                                            Swal.fire({
                                                                title: "Rectification",
                                                                text: "Inserer un nom template",
                                                                timer: 2000,
                                                                showConfirmButton: false
                                                            });
                                                        }
                                                        if (vv.length > 4) {
                                                            /*Swal.fire({
                                                             title: "Rectification",
                                                             text: "cet nom de template est existé déjà",
                                                             timer: 2000,
                                                             showConfirmButton: false
                                                             });*/
                                                            Swal.fire({
                                                                position: 'center',
                                                                type: 'success',
                                                                title: 'la template est créée',
                                                                showConfirmButton: false,
                                                                timer: 1500
                                                            });
                                                        }
                                                    });


                                                    /*swalWithBootstrapButtons.fire({
                                                     title: 'Vous êtes sûr ?',
                                                     text: "voulez-vous créer une template ?",
                                                     type: 'warning',
                                                     showCancelButton: true,
                                                     confirmButtonText: 'Oui',
                                                     cancelButtonText: 'No, annuler!',
                                                     reverseButtons: true
                                                     }).then((result) => {
                                                     if (result.value) {
                                                     
                                                     
                                                     swalWithBootstrapButtons.fire(
                                                     'Creation!',
                                                     'Votre template a été créé.',
                                                     'success')
                                                     } else if (
                                                     // Read more about handling dismissals
                                                     result.dismiss === Swal.DismissReason.cancel
                                                     ) {
                                                     }
                                                     });*/

                                                    break;
                                                case "Annuler modèle":
                                                    Swal.fire({
                                                        title: 'Vous êtes sûr ?',
                                                        text: "voulez-vous supprimer cette template ?",
                                                        type: 'warning',
                                                        showCancelButton: true,
                                                        confirmButtonColor: '#3085d6',
                                                        cancelButtonColor: '#d33',
                                                        confirmButtonText: 'Oui',
                                                        showCancelButton: true,
                                                        cancelButtonText: 'No, annuler!'
                                                    }).then((result) => {
                                                        if (result.value) {
                                                            Swal.fire(
                                                                    'Supprission!',
                                                                    'cette template a été supprimée.',
                                                                    'success')
                                                        }
                                                    });

                                                    break;
                                                case "Creation":

                                                    var table = $("table#tab_logic1 tbody");
                                                    var exist = 0;
                                                    table.find('tr').each(function (i, el) {
                                                        exist++;
                                                    });
                                                    //alert($("#dated").val());
                                                    if ($("#num").val().length == 0) {
                                                        Swal.fire({
                                                            title: "Rectification",
                                                            text: "Inserer un nouveau code",
                                                            timer: 2000,
                                                            showConfirmButton: false
                                                        });
                                                        /*} else if ($("#dated").val().length == 0) {
                                                         Swal.fire({
                                                         title: "Rectification",
                                                         text: "Inserer une date",
                                                         timer: 2000,
                                                         showConfirmButton: false
                                                         });
                                                         } else if ($("#destinateur_span").text() == "Select destinateur") {
                                                         Swal.fire({
                                                         title: "Rectification",
                                                         text: "Selectionner un destinateur",
                                                         timer: 2000,
                                                         showConfirmButton: false
                                                         });
                                                         } else if ($("#projet_span").text() == "Select projet") {
                                                         Swal.fire({
                                                         title: "Rectification",
                                                         text: "Selectionner un projet",
                                                         timer: 2000,
                                                         showConfirmButton: false
                                                         });
                                                         } else if ($("#total").val().length == 0) {
                                                         Swal.fire({
                                                         title: "Rectification",
                                                         text: "Insérer le contenu du tableau",
                                                         timer: 2000,
                                                         showConfirmButton: false
                                                         });
                                                         } else if ($("#nature_span").text() == "Select nature") {
                                                         Swal.fire({
                                                         title: "Rectification",
                                                         text: "Selectionner une nature de projet",
                                                         timer: 2000,
                                                         showConfirmButton: false
                                                         });
                                                         } else if (exist <= 2) {
                                                         Swal.fire({
                                                         title: 'Vous êtes sûr ?',
                                                         text: "voulez-vous créé sans attachments ?",
                                                         type: 'warning',
                                                         showCancelButton: true,
                                                         confirmButtonColor: '#3085d6',
                                                         cancelButtonColor: '#d33',
                                                         confirmButtonText: 'Oui',
                                                         showCancelButton: true,
                                                         cancelButtonText: 'No, annuler!'
                                                         }).then((result) => {
                                                         //
                                                         if (result.value) {
                                                         
                                                         }
                                                         });*/
                                                    } else {
                                                        /*Swal.fire({
                                                         title: "Rectification",
                                                         text: "Selectionner une nature de projet",
                                                         timer: 2000,
                                                         showConfirmButton: false
                                                         });*/
                                                        $.ajax({
                                                            url: '/IMTRADE/Ajouterdocument',
                                                            method: "POST",
                                                            data: {
                                                                fonction: "creation"
                                                            },
                                                            success: function (data) {
                                                                Swal.fire(
                                                                        'Creation!',
                                                                        'cette document a été créé.',
                                                                        'success')
                                                            }
                                                        });
                                                    }




                                                    /*$.ajax({
                                                     url: '/IMTRADE/Content',
                                                     method: "POST",
                                                     data: {
                                                     fonction: "creation"
                                                     },
                                                     success: function (data) {
                                                     
                                                     }
                                                     });
                                                     alert($(".skin-megna .sidebar-nav ul li a.active .hide-menu").text());*/
                                                    break;
                                                case "Confirmation":
                                                    var table = $("table#tab_logic2 tbody");
                                                    var exist = 0;
                                                    table.find('tr').each(function (i, el) {
                                                        exist++;
                                                    });
                                                    //alert(exist);
                                                    if (exist <= 2) {
                                                        Swal.fire({
                                                            title: 'Vous êtes sûr ?',
                                                            text: "voulez-vous confirmé sans attachments ?",
                                                            type: 'warning',
                                                            showCancelButton: true,
                                                            confirmButtonColor: '#3085d6',
                                                            cancelButtonColor: '#d33',
                                                            confirmButtonText: 'Oui',
                                                            showCancelButton: true,
                                                            cancelButtonText: 'No, annuler!'
                                                        }).then((result) => {
                                                            //
                                                            if (result.value) {
                                                                Swal.fire(
                                                                        'Confirmation!',
                                                                        'cette document a été confirmé.',
                                                                        'success')
                                                            }
                                                        });

                                                    }

                                                    break;
                                                case "Nouveau":
                                                    $('#prive').fadeOut(1000, function () {
                                                        $(this).remove();
                                                        $('#body_content').load('../DocIMTrade/New.jsp');
                                                    });
                                                    break;
                                            }


                                        });


                                    });

                                </script>

                                <!--<script  src="steps/css/table_dynamique.js"></script>-->
                                <jsp:include page='steps/css/tabledata.jsp' />
                                <jsp:include page='steps/css/select-type.jsp' />

                                <script type="text/javascript">
                                    $(document).ready(function () {
                                        /*
                                         var jsPDF=new jsPDF();
                                         if (jsPDF && jsPDF.version) {
                                         $('#dversion').text('Version ' + jsPDF.version);
                                         }
                                         */
                                        $(document).on("click", "#fullpage", function () {
                                            window.open('pdf.jsp', '_blank');
                                        });


                                        $(document).on("input", "#num", function () {
                                            this.value = this.value.replace(/\D/g, '');
                                        });


                                    <%
                                        String tab[] = {"destinateur", "projet", "nature", "type", "designation"};
                                        //HashMap<String,String> data = (HashMap<String,String>) session.getAttribute("hashMap");
                                        for (int idx = 0; idx < tab.length; idx++) {
                                            String elem = tab[idx];
                                    %>

                                        $("#dropdown-<%=elem%> li").on("click", function () {

                                            if ($(this).text().length > 0) {
                                    <%
                                        if (elem == "destinateur") {
                                    %>
                                                $('#destenreal').text("Doit à : " + $(this).text());
                                    <%
                                        }
                                    %>
                                                $('#<%=elem%>_span').removeAttr('class');
                                                $('#<%=elem%>_span').addClass($(this).attr("id"));

                                                var id = $(this).attr("id");
                                                $.ajax({
                                                    url: '/IMTRADE/Content',
                                                    method: "POST",
                                                    data: {
                                                        param: $(this).text(),
                                                        type: "<%=elem%>",
                                                        id_selected: id
                                                    },
                                                    success: function (data) {

                                    <%
                                        if (elem == "destinateur") {
                                    %>
                                                        $('#contentx').html(data);
                                    <%
                                    } else {
                                    %>
                                                        $('#scriptable').html(data);
                                    <%
                                        }
                                    %>                    //

                                                    }
                                                });

                                            }

                                        });

                                    <%
                                        }
                                    %>

                                    <%  //registre-agrement-nif-articlei
                                        String tab2[] = {"num", "dated", "datef", "Ref", "fax", "phone", "adr", "email", "rc", "agrr", "nif", "ai"};
                                        //HashMap<String,String> data = (HashMap<String,String>) session.getAttribute("hashMap");
                                        for (int idx = 0; idx < tab2.length; idx++) {
                                            String elem = tab2[idx];
                                    %>
                                        $("#<%=elem%>").bind("change paste keyup", function () {

                                            $.ajax({
                                                url: '/IMTRADE/Content',
                                                method: "POST",
                                                data: {
                                                    param: $(this).val(),
                                                    type: "<%=elem%>"
                                                },
                                                success: function (data) {

                                                    $('#numenreal').text("<%= doctype.getNomDocument()%> N°: " + $("#num").val() + "/<%=structure.getCode()%>/" + $("#dated").val().substring(2, 4));

                                                    $('#dateenreal').text($("#dated").val());
                                                    $('#contentx').html(data);

                                                }
                                            });
                                        });
                                    <%
                                        }
                                    %>
                                        //$('.steps ul .current a h3').html(data);        
                                        //alert("oui");
                                        $(document).on("change", ".title", function () {
                                            alert("oui");
                                        });
                                    });
                                </script>
                                <script>
                                    $('.dropdown0').click(function () {
                                        $(this).attr('tabindex', 1).focus();
                                        $(this).toggleClass('active');
                                        $(this).find('.dropdown-menu').slideToggle(300);
                                    });
                                    $('.dropdown0').focusout(function () {
                                        $(this).removeClass('active');
                                        $(this).find('.dropdown-menu').slideUp(300);
                                    });
                                    $('.dropdown0 .dropdown-menu li').click(function () {
                                        $(this).parents('.dropdown').find('span').text($(this).text());
                                        $(this).parents('.dropdown').find('input').attr('value', $(this).attr('id'));
                                    });
                                    $('body').addClass('mini-sidebar');

                                    //$('#myTable').DataTable();

                                    $('#SNTable').DataTable({

                                        "lengthMenu": [5, 10, 25, 50, 75, 100],

                                        "language": {
                                            "sProcessing": "Traitement en cours...",
                                            "sSearch": "Rechercher&nbsp;:",
                                            "sLengthMenu": "Afficher _MENU_ &eacute;l&eacute;ments",
                                            "sInfo": "Affichage de l'&eacute;lement _START_ &agrave; _END_ sur _TOTAL_ &eacute;l&eacute;ments",
                                            "sInfoEmpty": "Affichage de l'&eacute;lement 0 &agrave; 0 sur 0 &eacute;l&eacute;ments",
                                            "sInfoFiltered": "(filtr&eacute; de _MAX_ &eacute;l&eacute;ments au total)",
                                            "sInfoPostFix": "",
                                            "sLoadingRecords": "Chargement en cours...",
                                            "sZeroRecords": "Aucun &eacute;l&eacute;ment &agrave; afficher",
                                            "sEmptyTable": "Aucune donn&eacute;e disponible dans le tableau",
                                            "oPaginate": {
                                                "sFirst": "Premier",
                                                "sPrevious": "Pr&eacute;c&eacute;dent",
                                                "sNext": "Suivant",
                                                "sLast": "Dernier"
                                            },
                                            "oAria": {
                                                "sSortAscending": ": activer pour trier la colonne par ordre croissant",
                                                "sSortDescending": ": activer pour trier la colonne par ordre d&eacute;croissant"
                                            }
                                        }
                                    });


                                    var elems = Array.prototype.slice.call(document.querySelectorAll('.js-switch'));
                                    $('.js-switch').each(function () {
                                        new Switchery($(this)[0], $(this).data());
                                    });
                                    



                                </script>


                                </body>

                                </html>
                                <%
                                            }
                                        }
                                    }
                                %>