<%-- 
    Document   : index
    Created on : 30 juin 2020, 08:42:38
    Author     : Mechri
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
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
        <title>Account</title>
        <!-- This page CSS -->
        <!-- chartist CSS -->
        <link href="../assets/node_modules/morrisjs/morris.css" rel="stylesheet">
        <!--Toaster Popup message CSS -->
        <link href="../assets/node_modules/toast-master/css/jquery.toast.css" rel="stylesheet">
        <!-- Custom CSS -->
        <link href="../dist/css/style.min.css" rel="stylesheet">
        <!-- Dashboard 1 Page CSS -->
        <link href="../dist/css/pages/dashboard1.css" rel="stylesheet">
        <link rel="stylesheet" href="../dist/css/form/font-awesome.min.css">
        <link rel="stylesheet" href="../dist/css/form/font-awesome.min.css">
        <link rel="stylesheet" href="../dist/css/form/font-awesome.css">
    </head>
    <body class="skin-default fixed-layout">

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

                                <img src="../assets/images/logo-icon.png" alt="homepage" class="dark-logo" />
                                <!-- Light Logo icon -->
                                <img src="../assets/images/logo-light-icon.png" alt="homepage" class="light-logo" />
                            </b>
                            <span>
                                <!-- dark Logo text -->
                                <img src="../assets/images/logo-text.png" alt="homepage" class="dark-logo" />
                                <!-- Light Logo text -->    
                                <img src="../assets/images/logo-light-text.png" class="light-logo" alt="homepage" /></span> </a>
                    </div>

                    <div class="navbar-collapse">

                        <ul class="navbar-nav mr-auto">
                            <!-- This is  -->
                            <li class="nav-item"> <a class="nav-link nav-toggler d-block d-md-none waves-effect waves-dark" href="javascript:void(0)"><i class="ti-menu"></i></a> </li>
                            <li class="nav-item"> <a class="nav-link sidebartoggler d-none d-lg-block d-md-block waves-effect waves-dark" href="javascript:void(0)"><i class="icon-menu"></i></a> </li>

                            <li class="nav-item">
                                <form class="app-search d-none d-md-block d-lg-block">
                                    <input type="text" class="form-control" placeholder="Search & enter">
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


                                            </div>
                                        </li>
                                        <li>
                                            <a class="nav-link text-center link" href="javascript:void(0);"> <strong>Consulter toutes les notifications</strong> <i class="fa fa-angle-right"></i> </a>
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

                                            </div>
                                        </li>
                                        <li>
                                            <a class="nav-link text-center link" href="javascript:void(0);"> <strong>Voir tous les e-Mails</strong> <i class="fa fa-angle-right"></i> </a>
                                        </li>
                                    </ul>
                                </div>
                            </li>


                            <li class="nav-item dropdown u-pro">
                                <a class="nav-link dropdown-toggle waves-effect waves-dark profile-pic" href="" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"><img src="../assets/images/users/1.jpg" alt="user" class=""> <span class="hidden-md-down">USERNAME &nbsp;<i class="fa fa-angle-down"></i></span> </a>
                                <div class="dropdown-menu dropdown-menu-right animated flipInY">
                                    <!-- text-->
                                    <a href="javascript:void(0)" class="dropdown-item"><i class="ti-user"></i> Mon Profil</a>
                                    <!-- text-->
                                    <a href="javascript:void(0)" class="dropdown-item"><i class="ti-email"></i> e-Mails</a>

                                    <a href="javascript:void(0)" class="dropdown-item"><i class="ti-bell"></i> Notifications</a>
                                    <!-- text-->
                                    <div class="dropdown-divider"></div>
                                    <!-- text-->
                                    <a href="javascript:void(0)" class="dropdown-item"><i class="ti-settings"></i> Paramétrage</a>

                                    <a href="javascript:void(0)" class="dropdown-item"><i class="ti-lock"></i> Verrouiller</a>
                                    <!-- text-->
                                    <a href="pages-login.html" class="dropdown-item"><i class="fa fa-power-off"></i>  Se déconnecter</a>
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
                            <li class="user-pro"> <a class="has-arrow waves-effect waves-dark" href="javascript:void(0)" aria-expanded="false"><img src="../assets/images/users/1.jpg" alt="user-img" class="img-circle"><span class="hide-menu">Nom Prenom</span></a>
                                <ul aria-expanded="false" class="collapse">
                                    <li><a href="javascript:void(0)"><i class="ti-user"></i> Mon Profil</a></li>
                                    <li><a href="javascript:void(0)"><i class="ti-email"></i> e-Mails</a></li>
                                    <li><a href="javascript:void(0)"><i class="ti-bell"></i> Notifications</a></li>
                                    <li><a href="javascript:void(0)"><i class="ti-settings"></i> Paramétrage</a></li>
                                    <li><a href="javascript:void(0)"><i class="ti-lock"></i> Verrouiller</a></li>
                                    <li><a href="javascript:void(0)"><i class="fa fa-power-off"></i> Se déconnecter</a></li>
                                </ul>
                            </li>
                            <li class="nav-small-cap">--- Gestion de compte</li>
                            <li> <a class="has-arrow waves-effect waves-dark" href="javascript:void(0)" aria-expanded="false"><i class="ti-dashboard"></i><span class="hide-menu">Acceuil</span></span></a>
                                <ul aria-expanded="false" class="collapse">
                                    <li><a href="javascript:void(0)">Table de borde</a></li>
                                    <li><a href="javascript:void(0)"></a></li>
                                </ul>
                            </li>
                            <li> <a class="has-arrow waves-effect waves-dark" href="javascript:void(0)" aria-expanded="false"><i class="ti-email"></i><span class="hide-menu">e-Mails<span class="badge badge-pill badge-cyan ml-auto">0</span></span></span></a>
                                <ul aria-expanded="false" class="collapse">
                                    <li><a href="javascript:void(0)">Composer</a></li>
                                    <li><a href="javascript:void(0)">Mes e-Mails</a></li>
                                </ul>
                            </li>
                            <li> <a class="has-arrow waves-effect waves-dark" href="javascript:void(0)" aria-expanded="false"><i class="ti-bell"></i><span class="hide-menu">Notification<span class="badge badge-pill badge-primary text-white ml-auto">0</span></span></a>
                                <ul aria-expanded="false" class="collapse">
                                    <li><a href="javascript:void(0)">Creer</a></li>
                                    <li><a href="javascript:void(0)">Mes notification</a></li>

                                </ul>
                            </li>
                            <li class="nav-small-cap">--- Gestion de fichiers</li>
                            <li> <a class="has-arrow waves-effect waves-dark" href="javascript:void(0)" aria-expanded="false"><i class="ti-files"></i><span class="hide-menu">Document IMTRADE</a>
                                <ul aria-expanded="false" class="collapse">
                                    <li><a id="Nouveau" href="javascript:void(0)">Nouveau</a></li>
                                    <li><a id="Ouvrir" href="javascript:void(0)">Ouvrir</a></li>
                                    <li><a id="Parametrage" href="javascript:void(0)">Parametrage</a></li>
                                    <li><a id="Archive" href="javascript:void(0)">Archive</a></li>
                                </ul>
                            </li>
                            <li> <a class="has-arrow waves-effect waves-dark" href="javascript:void(0)" aria-expanded="false"><i class="ti-layout-grid3"></i><span class="hide-menu">Le stock</span></a>
                                <ul aria-expanded="false" class="collapse">
                                    <li><a id="stockconsult" href="#">Consulter stock</a></li>
                                </ul>
                            </li>


                            <li class="nav-small-cap">--- SUPPORT</li>
                            <!--<li> <a class="waves-effect waves-dark" href="../documentation/documentation.html" aria-expanded="false"><i class="far fa-circle text-success"></i><span class="hide-menu">Documentation</span></a></li>-->
                            <li> <a class="waves-effect waves-dark" href="pages-login.html" aria-expanded="false"><i class="far fa-circle text-danger"></i><span class="hide-menu">Déconnexion</span></a></li>
                            <!--<li> <a class="waves-effect waves-dark" href="pages-faq.html" aria-expanded="false"><i class="far fa-circle text-info"></i><span class="hide-menu">FAQs</span></a></li>-->
                        </ul>
                    </nav>
                    <!-- End Sidebar navigation -->
                </div>
                <!-- End Sidebar scroll-->
            </aside>

            <div class="page-wrapper">

                <div class="container-fluid">
