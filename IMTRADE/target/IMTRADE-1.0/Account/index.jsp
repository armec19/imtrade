<%-- 
    Document   : index
    Created on : 30 juin 2020, 08:42:38
    Author     : Mechri
--%>

<%@page import="maps.Membre"%>
<%@page import="maps.Utilisateur"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    if (session.getAttribute("Utilisateur") == null) {
        response.sendRedirect("../login.jsp");
    } else {
        Utilisateur utilisateur = (Utilisateur) session.getAttribute("Utilisateur");
        Membre membre = (Membre) session.getAttribute("Membre");
        if (session.getAttribute("islocked") == "true") {
            response.sendRedirect("../lock.jsp");
        } else {

%>
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
        <link rel="icon" type="image/png" sizes="16x16" href="../dist/favicon.ico">
        <title><%= membre.getNom() + " " + membre.getPrenom()%></title>

        <link rel="stylesheet" href="../assets/node_modules/morrisjs/morris.css">
        <script src="https://storage.googleapis.com/code.getmdl.io/1.0.6/material.min.js"></script>
        <link rel="stylesheet" href="https://storage.googleapis.com/code.getmdl.io/1.0.6/material.indigo-blue.min.css">
        <link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
        <link rel="stylesheet" href="../assets/node_modules/toast-master/css/jquery.toast.css">
        <!--debut mouadh-->
        <link rel='stylesheet' href='https://fonts.googleapis.com/css?family=Roboto:regular,bold,italic,thin,light,bolditalic,black,medium&amp;lang=en'>
        <link rel='stylesheet' href='https://code.getmdl.io/1.1.3/material.cyan-light_blue.min.css'>
        <!--fin mouadh-->
        <link rel="stylesheet" type="text/css" href="../assets/node_modules/datatables.net-bs4/css/dataTables.bootstrap4.css">
        <link rel="stylesheet" type="text/css" href="../assets/node_modules/datatables.net-bs4/css/responsive.dataTables.min.css">
        <link href="../assets/node_modules/bootstrap-table/dist/bootstrap-table.min.css" rel="stylesheet" type="text/css" />
        <link href="../assets/node_modules/calendar/dist/fullcalendar.css" rel="stylesheet" />
        <link rel="stylesheet" href="../dist/css/style.min.css">
        <link rel="stylesheet" href="../dist/css/pages/dashboard1.css">
        <link rel="stylesheet" href="../dist/css/form/font-awesome.min.css">

        <link rel="stylesheet" href="../dist/css/form/font-awesome.css">
        <link href="../dist/css/pages/user-card.css" rel="stylesheet">
        <link href="../assets/node_modules/Magnific-Popup-master/dist/magnific-popup.css" rel="stylesheet">

        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@9"></script>
        <script src="https://cdn.jsdelivr.net/npm/promise-polyfill"></script>

    </head>

    <body class="skin-default fixed-layout">

        <div class="preloader">
            <div class="loader">
                <div class="loader__figure"></div>
                <p class="loader__label">IDOCMAN</p>
            </div>
        </div>

        <div id="main-wrapper">

            <header class="topbar">
                <nav class="navbar top-navbar navbar-expand-md navbar-dark">

                    <div class="navbar-header">
                        <a class="navbar-brand logolink"  href="javascript:void(0);">
                            <b>
                                <img src="../assets/images/logo-icon.png" alt="homepage" class="dark-logo" />

                                <img src="../assets/images/logo-light-icon.png" alt="homepage" class="light-logo" />
                            </b>
                            <span>
                                <!--                                <img src="../assets/images/logo-text.png" alt="homepage" class="dark-logo" />
                                
                                                                <img src="../assets/images/logo-light-text.png" class="light-logo" alt="homepage" />-->
                            </span> 
                        </a>
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

                        <ul class="navbar-nav my-lg-0">

                            <li class="nav-item dropdown">
                                <a class="nav-link dropdown-toggle waves-effect waves-dark" href="" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"> <i class="ti-email"></i>
                                    <div class="notify"> <span class="heartbit"></span> <span class="point"></span> </div>
                                </a>
                                <div class="dropdown-menu dropdown-menu-right mailbox scale-up">
                                    <ul>
                                        <li>
                                            <div class="drop-title">Vous avez 0 nouveaux notifications</div>
                                        </li>
                                        <li>
                                            <div class="message-center">

                                                <!--
                                                <a href="javascript:void(0)">
                                                    <div class="btn btn-danger btn-circle"><i class="fa fa-link"></i></div>
                                                    <div class="mail-contnet">
                                                        <h5>Luanch Admin</h5> <span class="mail-desc">Just see the my new admin!</span> <span class="time">9:30 AM</span> </div>
                                                </a>
                                                 Message 
                                                <a href="javascript:void(0)">
                                                    <div class="btn btn-success btn-circle"><i class="ti-calendar"></i></div>
                                                    <div class="mail-contnet">
                                                        <h5>Event today</h5> <span class="mail-desc">Just a reminder that you have event</span> <span class="time">9:10 AM</span> </div>
                                                </a>
                                                 Message 
                                                <a href="javascript:void(0)">
                                                    <div class="btn btn-info btn-circle"><i class="ti-settings"></i></div>
                                                    <div class="mail-contnet">
                                                        <h5>Settings</h5> <span class="mail-desc">You can customize this template as you want</span> <span class="time">9:08 AM</span> </div>
                                                </a>
                                                 Message 
                                                <a href="javascript:void(0)">
                                                    <div class="btn btn-primary btn-circle"><i class="ti-user"></i></div>
                                                    <div class="mail-contnet">
                                                        <h5>Pavan kumar</h5> <span class="mail-desc">Just see the my admin!</span> <span class="time">9:02 AM</span> </div>
                                                </a>
                                                -->
                                            </div>
                                        </li>
                                        <li>
                                            <a class="nav-link text-center link ttnotifications" href="javascript:void(0);"> <strong>Consulter toutes les notifications</strong> <i class="fa fa-angle-right"></i> </a>
                                        </li>
                                    </ul>
                                </div>
                            </li>

                            <li class="nav-item dropdown">
                                <a class="nav-link dropdown-toggle waves-effect waves-dark" href="" id="2" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"> <i class="icon-note"></i>
                                    <div class="notify"> <span class="heartbit"></span> <span class="point"></span> </div>
                                </a>
                                <div class="dropdown-menu mailbox dropdown-menu-right scale-up" aria-labelledby="2">
                                    <ul>
                                        <li>
                                            <div class="drop-title">Vous avez 0 nouveaux messages</div>
                                        </li>
                                        <li>
                                            <div class="message-center">
                                                <!-- Message -->

                                                <!--                                                <a href="javascript:void(0)">
                                                                                                    <div class="user-img"> <img src="../assets/images/users/1.jpg" alt="user" class="img-circle"> <span class="profile-status online pull-right"></span> </div>
                                                                                                    <div class="mail-contnet">
                                                                                                        <h5>Pavan kumar</h5> <span class="mail-desc">Just see the my admin!</span> <span class="time">9:30 AM</span> </div>
                                                                                                </a>
                                                                                                 Message 
                                                                                                <a href="javascript:void(0)">
                                                                                                    <div class="user-img"> <img src="../assets/images/users/2.jpg" alt="user" class="img-circle"> <span class="profile-status busy pull-right"></span> </div>
                                                                                                    <div class="mail-contnet">
                                                                                                        <h5>Sonu Nigam</h5> <span class="mail-desc">I've sung a song! See you at</span> <span class="time">9:10 AM</span> </div>
                                                                                                </a>
                                                                                                 Message 
                                                                                                <a href="javascript:void(0)">
                                                                                                    <div class="user-img"> <img src="../assets/images/users/3.jpg" alt="user" class="img-circle"> <span class="profile-status away pull-right"></span> </div>
                                                                                                    <div class="mail-contnet">
                                                                                                        <h5>Arijit Sinh</h5> <span class="mail-desc">I am a singer!</span> <span class="time">9:08 AM</span> </div>
                                                                                                </a>
                                                                                                 Message 
                                                                                                <a href="javascript:void(0)">
                                                                                                    <div class="user-img"> <img src="../assets/images/users/4.jpg" alt="user" class="img-circle"> <span class="profile-status offline pull-right"></span> </div>
                                                                                                    <div class="mail-contnet">
                                                                                                        <h5>Pavan kumar</h5> <span class="mail-desc">Just see the my admin!</span> <span class="time">9:02 AM</span> </div>
                                                                                                </a>-->
                                            </div>
                                        </li>
                                        <li>
                                            <a class="nav-link text-center link ttmails" href="javascript:void(0);"> <strong>Voir tous les e-Mails</strong> <i class="fa fa-angle-right"></i> </a>
                                        </li>
                                    </ul>
                                </div>
                            </li>


                            <li class="nav-item dropdown u-pro">
                                <a class="nav-link dropdown-toggle waves-effect waves-dark profile-pic" href="" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"><img src="../assets/images/users/1.jpg" alt="user" class=""> <span class="hidden-md-down"><%= membre.getNom()%> &nbsp;<i class="fa fa-angle-down"></i></span> </a>
                                <div class="dropdown-menu dropdown-menu-right animated flipInY">
                                    <!-- text-->
                                    <a href="javascript:void(0)" class="dropdown-item"><i class="ti-user"></i> Mon Profil</a>
                                    <!-- text-->
                                    <a href="javascript:void(0)" class="dropdown-item ttmails"><i class="ti-email"></i> e-Mails</a>

                                    <a href="javascript:void(0)" class="dropdown-item ttnotifications"><i class="ti-bell"></i> Notifications</a>
                                    <!-- text-->
                                    <div class="dropdown-divider"></div>
                                    <!-- text-->
                                    <a href="javascript:void(0)" class="dropdown-item"><i class="ti-settings"></i> Paramétrage</a>

                                    <a href="javascript:void(0)" class="dropdown-item lock"><i class="ti-lock"></i> Verrouiller</a>
                                    <!-- text-->
                                    <a href="javascript:void(0)" class="dropdown-item outlog"><i class="fa fa-power-off"></i>  Se déconnecter</a>
                                    <!-- text-->
                                </div>
                            </li>

                            <li class="nav-item right-side-toggle"> <a class="nav-link  waves-effect waves-light" href="javascript:void(0)"><i class="ti-settings"></i></a></li>
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
                            <li class="user-pro"> <a class="has-arrow waves-effect waves-dark" href="javascript:void(0)" aria-expanded="false"><img src="../assets/images/users/1.jpg" alt="user-img" class="img-circle"><span class="hide-menu Allname">Nom Prenom</span></a>
                                <ul aria-expanded="false" class="collapse">
                                    <li><a href="javascript:void(0)"><i class="ti-user"></i> Mon Profil</a></li>
                                    <li><a href="javascript:void(0)" class="ttmails"><i class="ti-email"></i> e-Mails</a></li>
                                    <li><a href="javascript:void(0)" class="ttnotifications"><i class="ti-bell"></i> Notifications</a></li>
                                    <li><a href="javascript:void(0)"><i class="ti-settings"></i> Paramétrage</a></li>
                                    <li><a href="javascript:void(0)" class="lock"><i class="ti-lock"></i> Verrouiller</a></li>
                                    <li><a href="javascript:void(0)" class="outlog"><i class="fa fa-power-off"></i> Se déconnecter</a></li>
                                </ul>
                            </li>
                            <li class="nav-small-cap">--- Compte</li>
                            <li> 
                                <a class="has-arrow waves-effect waves-dark" href="javascript:void(0)" aria-expanded="false"><i class="ti-microsoft-alt"></i><span class="hide-menu">Acceuil</span></span></a>
                                <ul aria-expanded="false" class="collapse">
                                    <li><a href="javascript:void(0)">Bureau</a></li>
                                    <li><a href="javascript:void(0)">Table de borde</a></li>
                                </ul>
                            </li>
                            <li> 
                                <a class="has-arrow waves-effect waves-dark" href="javascript:void(0)" aria-expanded="false"><i class="ti-layout-grid2"></i><span class="hide-menu">Apps</span></span></a>
                                <ul aria-expanded="false" class="collapse">
                                    <li><a href="javascript:void(0)">Calendrier</a></li>
                                    <li><a href="javascript:void(0)">IMT Slack</a></li>
                                </ul>
                            </li>
                            <li> 
                                <a class="has-arrow waves-effect waves-dark" href="javascript:void(0)" aria-expanded="false"><i class="ti-email"></i><span class="hide-menu">e-Mails<span class="badge badge-pill badge-cyan ml-auto">0</span></span></span></a>
                                <ul aria-expanded="false" class="collapse">
                                    <li><a href="javascript:void(0)">Composer</a></li>
                                    <li><a href="javascript:void(0)">Mes e-Mails</a></li>
                                </ul>
                            </li>
                            <li> <a class="has-arrow waves-effect waves-dark" href="javascript:void(0)" aria-expanded="false"><i class="ti-bell"></i><span class="hide-menu">Notification<span class="badge badge-pill badge-primary text-white ml-auto">0</span></span></a>
                                <ul aria-expanded="false" class="collapse">
                                    <li><a href="javascript:void(0)">Creer</a></li>
                                    <li><a href="javascript:void(0)">Mes notifications</a></li>

                                </ul>
                            </li>
                            <li class="nav-small-cap">--- Management des fichiers</li>
                            <li> <a class="has-arrow waves-effect waves-dark" href="javascript:void(0)" aria-expanded="false"><i class="ti-file"></i><span class="hide-menu">Document IMTRADE</a>
                                <ul aria-expanded="false" class="collapse">
                                    <li><a id="Nouveau" href="javascript:void(0)">Nouveau</a></li>
                                    <li><a id="Ouvrir" href="javascript:void(0)">Ouvrir</a></li>
                                    <li><a id="Brouillon" href="javascript:void(0)">Brouillon</a></li>
                                    <li><a id="Managment" href="javascript:void(0)">Propriétaire</a></li>
                                </ul>
                            </li>
                            <li> <a class="has-arrow waves-effect waves-dark" href="javascript:void(0)" aria-expanded="false"><i class="ti-files"></i><span class="hide-menu">Gestionnaire</a>
                                <ul aria-expanded="false" class="collapse">
                                    <li><a id="Mes_documents" href="javascript:void(0)">Mes documents</a></li>
                                    <li><a id="Archive" href="javascript:void(0)">Archive IMTRADE</a></li>
                                </ul>
                            </li>

                            <li class="nav-small-cap">--- SUPPORT</li>
                            <li> 
                                <a class="has-arrow waves-effect waves-dark" href="javascript:void(0)" aria-expanded="false"><i class="ti-layout-grid3"></i><span class="hide-menu">Le stock</span></a>
                                <ul aria-expanded="false" class="collapse">
                                    <li><a id="stockconsult" href="#">Consulter stock</a></li>
                                </ul>
                            </li>
                            <li> <a class="waves-effect waves-dark lock" href="javascript:void(0)" aria-expanded="false"><i class="far fa-circle text-warning"></i><span class="hide-menu">Verrouiller</span></a></li>
                            <li> <a class="waves-effect waves-dark outlog" href="javascript:void(0)" aria-expanded="false"><i class="far fa-circle text-danger"></i><span class="hide-menu">Déconnexion</span></a></li>
                            <!--<li> <a class="waves-effect waves-dark" href="pages-faq.html" aria-expanded="false"><i class="far fa-circle text-info"></i><span class="hide-menu">FAQs</span></a></li>-->
                        </ul>
                    </nav>
                    <!-- End Sidebar navigation -->
                </div>
                <!-- End Sidebar scroll-->
            </aside>

            <div class="page-wrapper">

                <div class="container-fluid">

                    <div id="body_content">

                        <jsp:include page="<%=(String) session.getAttribute("Selectedpage")%>" />
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
            <div class="modal bottom-sheet" id="file_context_menu">
                <div class="modal-content">
                    <div class="row">
                        <h5>File context menu</h5>
                        <div class="divider"></div>
                        <div class="divider"></div>
                    </div>
                    <div class="row center no-margin-bottom">
                        <div class="col s4 section">
                            <div class="row"><a class="btn-flat waves-effect hoverable">Copy<i class="material-icons left">content_copy</i></a></div>
                            <div class="row"><a class="btn-flat waves-effect hoverable">Move<i class="material-icons left">subdirectory_arrow_right</i></a></div>
                        </div>
                        <div class="col s4 section">
                            <div class="row"><a class="btn-flat waves-effect hoverable">Delete<i class="material-icons left">delete</i></a></div>
                            <div class="row"><a class="btn-flat waves-effect hoverable">Export<i class="material-icons left">file_download</i></a></div>
                            <div class="row no-margin-bottom"><a class="btn-flat waves-effect hoverable">Properties<i class="material-icons left">info_outline</i></a></div>
                        </div>
                        <div class="col s4 section">
                            <div class="row"><a class="btn-flat waves-effect hoverable">Rename<i class="material-icons left">description</i></a></div>
                            <div class="row"><a class="btn-flat waves-effect hoverable">Tag<i class="material-icons left">label_outline</i></a></div>
                        </div>
                    </div>
                </div>
            </div>
            <footer class="footer">
                © 2020 IMTRADE
            </footer>

        </div>

        <script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.0/jquery.min.js"></script> 
        <!--        <script src="../assets/node_modules/popper/popper.min.js"></script>
                <script src="../assets/node_modules/bootstrap/dist/js/bootstrap.min.js"></script>-->
        <!--<script src="../assets/node_modules/toast-master/js/jquery.toast.js"></script>-->
        <script src='https://cdnjs.cloudflare.com/ajax/libs/jquery/3.0.0-alpha1/jquery.min.js'></script>
        <%--<jsp:include page="Model/manageTable.jsp" />--%>
        <script src="../Account/Model/scriptproduct.js"></script>

        <script src='https://s3-us-west-2.amazonaws.com/s.cdpn.io/4579/list.min.js'></script>

        <script src="../assets/node_modules/Magnific-Popup-master/dist/jquery.magnific-popup.min.js"></script>
        <script src="../assets/node_modules/Magnific-Popup-master/dist/jquery.magnific-popup-init.js"></script>
        <script src="../dist/js/perfect-scrollbar.jquery.min.js"></script>
        <script src="../dist/js/waves.js"></script>
        <script src="../dist/js/sidebarmenu.js"></script>
        <script src="../dist/js/custom.min.js"></script>

        <script src="../assets/node_modules/raphael/raphael-min.js"></script>
        <script src="../assets/node_modules/morrisjs/morris.min.js"></script>
        <script src="../assets/node_modules/jquery-sparkline/jquery.sparkline.min.js"></script>

        <script src="../assets/node_modules/toast-master/js/jquery.toast.js"></script>
        <script src="../assets/node_modules/sticky-kit-master/dist/sticky-kit.min.js"></script>
        <script src="../assets/node_modules/sparkline/jquery.sparkline.min.js"></script>  
        <script src="../assets/node_modules/calendar/jquery-ui.min.js"></script>
        <script src="../assets/node_modules/moment/moment.js"></script>
        <script src='../assets/node_modules/calendar/dist/fullcalendar.min.js'></script>
        <script src="../assets/node_modules/calendar/dist/cal-init.js"></script>

        <script>
            // This is for the sticky sidebar    
            $(".Allname").text("<%= membre.getNom()%>");
            $(".Name").text("<%= membre.getNom()%>");
            //$(".Allname").text($(".Allname").text().substring(0,16));
            $(".stickyside").stick_in_parent({
                offset_top: 100
            });


            $('.stickyside a').click(function () {
                $('html, body').animate({
                    scrollTop: $($(this).attr('href')).offset().top - 100
                }, 500);
                return false;
            });

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
            $(function () {

                $(".ttnotifications").click(function () {
                    $.ajax({
                        url: '/IMTRADE/SelectFile',
                        method: "POST",
                        data: {
                            type: "selectpage",
                            page: "Notifications.jsp"
                        },
                        success: function (data) {
                            window.open('index.jsp', '_self');
                        }
                    });
                });
                $(".ttmails").click(function () {
                    $.ajax({
                        url: '/IMTRADE/SelectFile',
                        method: "POST",
                        data: {
                            type: "selectpage",
                            page: "Mailing/Mails.jsp"
                        },
                        success: function (data) {
                            window.open('index.jsp', '_self');
                        }
                    });
                });

                $("a").click(function () {
                    switch ($(this).text()) {
                        case "Ouvrir":
                            $.ajax({
                                url: '/IMTRADE/SelectFile',
                                method: "POST",
                                data: {
                                    type: "selectpage",
                                    page: "DocIMTrade/Ouvrir.jsp"
                                },
                                success: function (data) {
                                    window.open('index.jsp', '_self');
                                }
                            });
//                            $('#prive').fadeOut(1000, function () {
//                                //$(this).remove();
//                                $('#body_content').load('DocIMTrade/Ouvrir.jsp');
//                            });
                            break;
                        case "Brouillon":
                            $.ajax({
                                url: '/IMTRADE/SelectFile',
                                method: "POST",
                                data: {
                                    type: "selectpage",
                                    page: "DocIMTrade/Brouillon.jsp"
                                },
                                success: function (data) {
                                    window.open('index.jsp', '_self');
                                }
                            });
                            break;
                        case "Nouveau":
//                            $('#prive').fadeOut(1000, function () {
//                                //$(this).remove();
//                                $('#body_content').load('DocIMTrade/New.jsp');
//                            });
                            $.ajax({
                                url: '/IMTRADE/SelectFile',
                                method: "POST",
                                data: {
                                    type: "selectpage",
                                    page: "DocIMTrade/New.jsp"
                                },
                                success: function (data) {
                                    window.open('index.jsp', '_self');
                                }
                            });
                            break;
                        case "Archive IMTRADE":
//                            jQuery("#body_content").load('DocIMTrade/Archive.jsp');
                            $.ajax({
                                url: '/IMTRADE/SelectFile',
                                method: "POST",
                                data: {
                                    type: "selectpage",
                                    page: "DocIMTrade/Archive.jsp"
                                },
                                success: function (data) {
                                    window.open('index.jsp', '_self');
                                }
                            });
                            break;
                        case "Mes documents":
//                            jQuery("#body_content").load('DocIMTrade/Archive.jsp');
                            $.ajax({
                                url: '/IMTRADE/SelectFile',
                                method: "POST",
                                data: {
                                    type: "selectpage",
                                    page: "DocIMTrade/Mesdocuments.jsp"
                                },
                                success: function (data) {
                                    window.open('index.jsp', '_self');
                                }
                            });
                            break;
                        case "Propriétaire":
//                            $('#prive').fadeOut(1000, function () {
//                                //$(this).remove();
//                                $('#body_content').load('DocIMTrade/Managment.jsp');
//                            });
                            $.ajax({
                                url: '/IMTRADE/SelectFile',
                                method: "POST",
                                data: {
                                    type: "selectpage",
                                    page: "DocIMTrade/Managment.jsp"
                                },
                                success: function (data) {
                                    window.open('index.jsp', '_self');
                                }
                            });
                            break;
                        case "Bureau":
                            $.ajax({
                                url: '/IMTRADE/SelectFile',
                                method: "POST",
                                data: {
                                    type: "selectpage",
                                    page: "Main.jsp"
                                },
                                success: function (data) {
                                    window.open('index.jsp', '_self');
                                }
                            });
                            break;
                        case "Table de borde":
                            $.ajax({
                                url: '/IMTRADE/SelectFile',
                                method: "POST",
                                data: {
                                    type: "selectpage",
                                    page: "Borde.jsp"
                                },
                                success: function (data) {
                                    window.open('index.jsp', '_self');
                                }
                            });
                            break;
                        case "Calendrier":
                            $.ajax({
                                url: '/IMTRADE/SelectFile',
                                method: "POST",
                                data: {
                                    type: "selectpage",
                                    page: "Apps/Calendar.jsp"
                                },
                                success: function (data) {
                                    window.open('index.jsp', '_self');
                                }
                            });
                            break;
                        case "IMT Slack":
                            $.ajax({
                                url: '/IMTRADE/SelectFile',
                                method: "POST",
                                data: {
                                    type: "selectpage",
                                    page: "Apps/Slack.jsp"
                                },
                                success: function (data) {
                                    window.open('index.jsp', '_self');
                                }
                            });
                            break;
                        case "Composer":
//                            $('#prive').fadeOut(1000, function () {
//                                //$(this).remove();
//                                $('#body_content').load('Mailing/Compose.jsp');
//
//                            });
                            $.ajax({
                                url: '/IMTRADE/SelectFile',
                                method: "POST",
                                data: {
                                    type: "selectpage",
                                    page: "Mailing/Compose.jsp"
                                },
                                success: function (data) {
                                    window.open('index.jsp', '_self');
                                }
                            });
                            break;
                        case "Mes e-Mails":
//                            $('#prive').fadeOut(1000, function () {
//                                //$(this).remove();
//                                $('#body_content').load('Mailing/Mails.jsp');
//                                //location.reload(true);
//                            });
                            $.ajax({
                                url: '/IMTRADE/SelectFile',
                                method: "POST",
                                data: {
                                    type: "selectpage",
                                    page: "Mailing/Mails.jsp"
                                },
                                success: function (data) {
                                    window.open('index.jsp', '_self');
                                }
                            });
                            break;
                        case "Creer":
//                            $('#prive').fadeOut(1000, function () {
//                                //$(this).remove();
//
//                                $('#body_content').load('AddNotification.jsp');
//
//                            });
                            $.ajax({
                                url: '/IMTRADE/SelectFile',
                                method: "POST",
                                data: {
                                    type: "selectpage",
                                    page: "AddNotification.jsp"
                                },
                                success: function (data) {
                                    window.open('index.jsp', '_self');
                                }
                            });
                            break;
                        case "Mes notifications":
//                            $('#prive').fadeOut(1000, function () {
//                                //$(this).remove();
//
//                                $('#body_content').load('Notifications.jsp');
//
//                            });
                            $.ajax({
                                url: '/IMTRADE/SelectFile',
                                method: "POST",
                                data: {
                                    type: "selectpage",
                                    page: "Notifications.jsp"
                                },
                                success: function (data) {
                                    window.open('index.jsp', '_self');
                                }
                            });
                            break;
                        case "Consulter stock":
                            //$('#prive').fadeOut(500, function () {
                            //$(this).remove();
                            $.ajax({
                                url: '/IMTRADE/SelectFile',
                                method: "POST",
                                data: {
                                    type: "selectpage",
                                    page: "Stock/Consult.jsp"
                                },
                                success: function (data) {
                                    window.open('index.jsp', '_self');
                                }
                            });
                            //});
                            break;

                    }
                });
                //Newfile
                $("a.file").click(function () {
                    //alert($(this).attr("id"));
                    //window.open('File/imtrade_document.jsp', "_self");
                    //$(".preloader").css("display","block");
                    $.ajax({
                        url: '/IMTRADE/SelectFile',
                        method: "POST",
                        data: {
                            idfile: $(this).attr("id"),
                            type: "selectfile"
                        },
                        success: function (data) {


                            window.open('File/doc.jsp', "_self");
                        }
                    });

                });


                $(".logolink").click(function () {
                    window.open('index.jsp', '_self');
                });



            });
            $(function () {
                "use strict";
                //This is for the Notification top right
            <%
                if (session.getAttribute("logged") != null) {
                    if (session.getAttribute("logged") == "yes") {
                        session.setAttribute("logged", null);

            %>
                $.toast({
                    heading: '\n\nBienvenu au IDOCMAN'
                    , text: 'Mr. <%= membre.getNom() + " " + membre.getPrenom()%>'
                    , position: 'top-right'
                    , loaderBg: '#ff6849'
                    , icon: 'info'
                    , hideAfter: 4000
                    , stack: 10
                });
            <%
                    }
                }
            %>
                $(document).on("click", ".outlog", function (event) {
                    event.preventDefault();

                    //$('.preloader').show();
                    $.ajax({
                        url: '/IMTRADE/AccountManager',
                        method: "POST",
                        data: {
                            type: "logout"
                        },
                        success: function (data) {
                            //$('.preloader').hide();
                            window.open('../login.jsp', '_self');

                        }
                    });
                });

                $(document).on("click", ".lock", function (event) {
                    event.preventDefault();

                    $('.preloader').show();
                    $.ajax({
                        url: '/IMTRADE/AccountManager',
                        method: "POST",
                        data: {
                            type: "lock"
                        },
                        success: function (data) {
                            //$('.preloader').hide();
                            window.open('../lock.jsp', '_self');
                        }
                    });
                });

                $(document).on("click", "#btn00", function (event) {
//        $('form').submit(function (event) {
                    //alert("ok");
                    // get the form data
                    // there are many ways to get this data using jQuery (you can use the class or id also)
                    //StructureCapitaladresseRegistreN.I.FN.I.SA.R.TRIBBanqueSiteContact (Tel/Fax)
                    var formData = {
                        'txt1': $('#txt1').val(),
                        'txt2': $('#txt2').val(),
                        'txt3': $('#txt3').val(),
                        'txt4': $('#txt4').val(),
                        'txt5': $('#txt5').val(),
                        'txt6': $('#txt6').val(),
                        'txt7': $('#txt7').val(),
                        'txt8': $('#txt8').val(),
                        'txt9': $('#txt9').val(),
                        'txt10': $('#txt10').val(),
                        'txt11': $('#txt11').val()
                    };

                    // process the form
                    $.ajax({
                        type: 'POST', // define the type of HTTP verb we want to use (POST for our form)
                        url: '/IMTRADE/Ajouterdocument', // the url where we want to POST
                        data: formData, // our data object
                        success: function (data) {
                            if (data == "oui") {
                                Swal.fire({
                                    position: 'center',
                                    type: 'error',
                                    title: 'Rectification',
                                    text: "editer les renseignements",
                                    showConfirmButton: false,
                                    timer: 2000
                                })

                            }
                            if (data == "non") {
                                const swalWithBootstrapButtons = Swal.mixin({
                                    customClass: {
                                        confirmButton: 'btn btn-success waves-effect waves-light',
                                        cancelButton: 'mr-2 btn btn-danger waves-effect waves-light'
                                    },
                                    buttonsStyling: false,
                                });
                                swalWithBootstrapButtons.fire(
                                        'Edition!',
                                        'la modification a été effectuée.',
                                        'success');

                            }
                        }
                    });


//            $.ajax({
//                type: 'POST', // define the type of HTTP verb we want to use (POST for our form)
//                url: '/IMTRADE/Ajouterdocument', // the url where we want to POST
//                data: formData, // our data object
//                dataType: 'json', // what type of data do we expect back from the server
//                encode: true
//            }).done(function (data) {
//                alert(data);
//            });

                    event.preventDefault();
                });



                //could used
                /*$(".nav-pills .nav-link.active, .nav-pills .show > .nav-link a").on("click", function () {
                 //$('.nav-pills .nav-link.active, .nav-pills .show > .nav-link a').click(function () {
                 alert("ok");
                 });*/



                /*var dialog = document.querySelector('dialog');
                 $(".remove-row").on("click", function () {
                 $(".mdl-dialog__addContent").remove();
                 
                 if ($(".mdl-data-dynamictable tbody").find('tr.is-selected').length != 0)
                 {
                 dialog.showModal();
                 }
                 
                 
                 
                 });
                 $(document).on("click", ".mdl-checkbox", function () {
                 var _tableRow = $(this).parents("tr:first");
                 if ($(this).hasClass("is-checked") === false) {
                 _tableRow.addClass("is-selected");
                 //is-checked
                 $(this).children(".is-upgraded").addClass("");
                 } else {
                 _tableRow.removeClass("is-selected");
                 }
                 
                 });
                 $(document).on("click", "#checkbox-all", function () {
                 _isChecked = $(this).parent("label").hasClass("is-checked");
                 if (_isChecked === false) {
                 $(".mdl-data-dynamictable").find('tr').addClass("is-selected");
                 $(".mdl-data-dynamictable").find('tr td label').addClass("is-checked");
                 } else {
                 $(".mdl-data-dynamictable").find('tr').removeClass("is-selected");
                 $(".mdl-data-dynamictable").find('tr td label').removeClass("is-checked");
                 }
                 
                 });*/



            });

        </script>

        <script src='https://cdn.datatables.net/buttons/1.3.1/js/buttons.html5.min.js'></script>
        <script src='https://cdn.datatables.net/buttons/1.3.1/js/buttons.print.min.js'></script>
        <script src='https://cdn.datatables.net/buttons/1.3.1/js/dataTables.buttons.min.js'></script>
        <script src='https://cdn.jsdelivr.net/npm/babel-polyfill/dist/polyfill.min.js'></script>
        <script src='https://cdn.jsdelivr.net/npm/vue/dist/vue.js'></script>
        <script src='https://cdn.jsdelivr.net/npm/vuetify@1.1.10/dist/vuetify.min.js'></script>
        <script src='https://cdnjs.cloudflare.com/ajax/libs/jszip/3.1.3/jszip.min.js'></script>

        <!--        
                <script src="https://unpkg.com/tableexport.jquery.plugin/tableExport.min.js"></script>
                <script src="../assets/node_modules/bootstrap-table/dist/bootstrap-table.min.js"></script>
                <script src="../assets/node_modules/bootstrap-table/dist/bootstrap-table-locale-all.min.js"></script>
                <script src="../assets/node_modules/bootstrap-table/dist/extensions/export/bootstrap-table-export.min.js"></script>
                <script src="../dist/js/pages/bootstrap-table.init.js"></script>
        -->
        <!--js test-->
        <!--<script src="../assets/node_modules/datatables.net/js/jquery.dataTables.min.js"></script>-->
        <!--<script src="../assets/node_modules/datatables.net-bs4/js/dataTables.responsive.min.js"></script>-->
        <!--<script src="https://gyrocode.github.io/jquery-datatables-checkboxes/1.2.12/js/dataTables.checkboxes.min.js"></script>-->
        <!--debut mouadh-->
        <script src='https://code.getmdl.io/1.1.3/material.min.js'></script>
        <script src="../assets/node_modules/datatables.net-bs4/js/dataTables.responsive.min.js"></script>
        <!--fin mouadh-->
        <!-- start - This is for export functionality only -->
        <script src="https://cdn.datatables.net/buttons/1.5.1/js/dataTables.buttons.min.js"></script>
        <script src="https://cdn.datatables.net/buttons/1.5.1/js/buttons.flash.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jszip/3.1.3/jszip.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.32/pdfmake.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.32/vfs_fonts.js"></script>
        <script src="https://cdn.datatables.net/buttons/1.5.1/js/buttons.html5.min.js"></script>
        <script src="https://cdn.datatables.net/buttons/1.5.1/js/buttons.print.min.js"></script>

        <%--<jsp:include page="Model/script_table_model.jsp" />--%>
        <script src="../assets/node_modules/popper/popper.min.js"></script>
        <script src="../assets/node_modules/bootstrap/dist/js/bootstrap.min.js"></script>
        <script src="../assets/node_modules/datatables.net/js/jquery.dataTables.min.js"></script>

        <!--_-->
    </body>
</html>

<%
        }
    }
%>