<%-- 
    Document   : login
    Created on : 25 juin 2020, 10:22:06
    Author     : Mechri
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    
    if (session.getAttribute("Utilisateur") != null) {

        if (session.getAttribute("islocked") == "true") {
            response.sendRedirect("lock.jsp");
        } else {
            response.sendRedirect("Account/index.jsp");
        }
        
    } else {
        session.setAttribute("logged", "yes");
%>
<!DOCTYPE html>
<html lang="en">

    <head>
        <jsp:include page="out_header.jsp"/>


    </head>

    <body>

        <div class="preloader">
            <div class="loader">
                <div class="loader__figure"></div>
                <p class="loader__label">IMANAGE</p>
            </div>
        </div>

        <section id="wrapper" class="login-register login-sidebar" style="background-image:url(assets/images/background/login-register.jpg);">
            <div class="login-box card">
                <div class="card-body">
                    <form class="form-horizontal form-material text-center" id="loginform">
                        <a href="javascript:void(0)" class="db"><img src="dist/logo1.png" style="width: 50%;" alt="Home" /><br/>
                            <!--img src="../assets/images/logo-text.png" alt="Home" /--></a>

                        <div class="form-group m-t-40">
                            <div class="col-xs-12">
                                <input class="form-control" id="userlogin" type="text" required="" placeholder="Adresse mail">
                            </div>
                            <div id="nonvalid1" class="text-left col-xs-12" style="display: none;">
                                <p style="

                                   margin-left: 1%;
                                   font-size: 10px;
                                   font-weight: bold;
                                   color: #ff2a2a;
                                   ">contenu est non valide</p>
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="col-xs-12">

                                <input class="form-control" id="passlogin" type="password" required="" placeholder="Mot de passe">
                            </div>
                            <div id="nonvalid2" class="text-left col-xs-12" style="display: none;">
                                <p style="

                                   margin-left: 1%;
                                   font-size: 10px;
                                   font-weight: bold;
                                   color: #ff2a2a;
                                   ">contenu est non valide</p>
                            </div>

                        </div>
                        <div class="form-group row">
                            <div class="col-md-12">
                                <div class="d-flex no-block align-items-center">
                                    <div class="custom-control custom-checkbox">
                                        <input type="checkbox" class="custom-control-input" checked="checked" id="customCheck1">
                                        <label class="custom-control-label" for="customCheck1">Remember me</label>
                                    </div> 
                                    <div class="ml-auto">
                                        <a href="javascript:void(0)" id="to-recover" class="text-muted"><i class="fa fa-lock m-r-5"></i>Mot de passe oublié ?</a> 
                                    </div>
                                </div>   
                            </div>
                        </div>
                        <div class="form-group text-center m-t-20">
                            <div class="col-xs-12">
                                <button id="loginbtn" class="btn btn-info btn-lg btn-block text-uppercase btn-rounded" >Se connecter</button>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-xs-12 col-sm-12 col-md-12 m-t-10 text-center">
                                <div class="social">

                                    <button class="btn btn-googleplus" data-toggle="tooltip" style="width:50px" title="S'authentifier avec google"> <i aria-hidden="true" class="fab fa-google-plus-g"></i> </button>
                                </div>
                            </div>
                        </div>
                        <div class="form-group m-b-0">
                            <div class="col-sm-12 text-center">
                                Vous n'avez pas de compte ? <a href="pages-register2.html" class="text-primary m-l-5"><b>Contacter nous</b></a>
                            </div>
                        </div>
                    </form>
                    <form class="form-horizontal form-material" id="recoverform">
                        <div class="form-group ">
                            <div class="col-xs-12">
                                <h4 class="text-cente">Récupération le mot de passe</h4>
                                <p class="text-muted">Entrez votre email et des instructions vous seront envoyées !</p>
                            </div>
                        </div>
                        <div class="form-group ">
                            <div class="col-xs-12">
                                <input class="form-control" type="email" id="emailresetpass" name="mailparam" data-validation-required-message="Ce champ est obligatoire" required="" placeholder="Email">
                                <input type="hidden" id="recouver" name="type" value="recouver">
                            </div>
                        </div>
                        <div class="form-group text-center row">
                            <div class="col-md-6">
                                <button class="btn btn-success btn-lg btn-block text-uppercase waves-effect waves-light Reset" type="submit">Reset</button>
                            </div>
                            <div class="col-md-6">
                                <button class="btn btn-info btn-lg btn-block text-uppercase waves-effect waves-light Retourner" type="button">Retourner</button>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </section>

        <jsp:include page="out_footer.jsp"/>
        <script type="text/javascript">
            $(document).ready(function () {

                $(document).on("click", ".Retourner", function () {

                    $("#recoverform").hide();
                    $("#loginform").show();

                });

                $(document).on("click", ".Reset", function (event) {

                    event.preventDefault();

                    if ($("#emailresetpass").val() == "") {
                        alert("Inserer votre mail");
                    } else {
                        $('.preloader').show();
                        $.ajax({
                            url: '/IMTRADE/AccountManager',
                            method: "POST",
                            data: {
                                mailparam: $("#emailresetpass").val(),
                                type: "recouver"
                            },
                            success: function (data) {
                                $('.preloader').hide();
                                if (data == "empty") {
                                    alert("Ce mail n'existe pas");
                                } else {
                                    if (data == "false") {
                                       window.open('Error/500.jsp', '_self');
                                    }
                                    else{
                                        window.open('recouver.jsp', '_self');
                                    }
                                    
                                }
                                //alert("Ce mail n'existe pas");
                                //window.open('recouver.jsp', '_self');
                            }
                        });

                    }

                });

                $(document).on("click", "#loginbtn", function (event) {
                    event.preventDefault();
                    
                    if ($("#userlogin").val().length > 0 && $("#passlogin").val().length > 0)
                    {

                        if ($("#nonvalid1").css("display") === "none" && $("#nonvalid2").css("display") === "none") {

                            $('.preloader').show();
                            $.ajax({
                                url: '/IMTRADE/AccountManager',
                                method: "POST",
                                data: {
                                    userparam: $("#userlogin").val(),
                                    passparam: $("#passlogin").val(),
                                    type: "login"
                                },
                                success: function (data) {
                                    $('.preloader').hide();
                                    if (data == "0") {
                                        alert("Ce compte n'existe pas");
                                    } else {
                                        window.open('Account/index.jsp', '_self');
                                    }

                                }
                            });

                        } else {
                            alert("Compléter vous informations");
                        }

                    } else
                    {
                        alert("Compléter vous informations");
                    }

                });
            });
        </script>
    </body>

</html>
<%
    }
%>