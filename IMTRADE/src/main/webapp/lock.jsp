<%-- 
    Document   : lock
    Created on : 25 juin 2020, 10:22:48
    Author     : Mechri
--%>

<%@page import="maps.Utilisateur"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    if (session.getAttribute("Utilisateur") == null) {
        response.sendRedirect("login.jsp");
    } else {
        Utilisateur utilisateur=(Utilisateur)session.getAttribute("Utilisateur");
        if (session.getAttribute("islocked") == "false") {
            response.sendRedirect("Account/index.jsp");
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

        <section id="wrapper">
            <div class="login-register" style="background-image:url(assets/images/background/login-register.jpg);">
                <div class="login-box card">
                    <div class="card-body">
                        <form class="form-horizontal form-material" id="loginform">
                            <div class="form-group">
                                <div class="col-xs-12 text-center">
                                    <div class="user-thumb text-center"> <img alt="thumbnail" class="img-circle" width="100" src="assets/images/users/1.jpg">
                                        <h5 style="color:#03a9f3;font-weight: bolder;margin-top: 20px;"><%= utilisateur.getUsername() %></h5>
                                    </div>
                                </div>
                            </div>
                            <div class="form-group ">
                                <div class="col-xs-12">
                                    <input class="form-control" type="password" id="passlock" required="true" placeholder="Mot de passe">
                                </div>
                            </div>
                            <div class="form-group text-center row">
                                <div class="col-md-6">
                                    <button class="btn btn-info btn-lg btn-block text-uppercase waves-effect waves-light unlockbtn" style="font-size: 15px;" type="submit">S'authentifier</button>
                                </div>
                                <div class="col-md-6">
                                    <button class="btn btn-danger btn-lg btn-block text-uppercase waves-effect waves-light outlog" style="font-size: 15px;" type="submit">Se déconnecter</button>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </section>
        <jsp:include page="out_footer.jsp"/>
        <script type="text/javascript">
            $(document).ready(function () {
                $(document).on("click", ".unlockbtn", function (event) {
                    event.preventDefault();

                    $('.preloader').show();
                    $.ajax({
                        url: '/IMTRADE/AccountManager',
                        method: "POST",
                        data: {
                            passparam : $("#passlock").val(),
                            type: "unlock"
                        },
                        success: function (data) {
                            $('.preloader').hide();
                            if (data == "0") {
                                alert("Informations non correcte");
                            } else {
                                window.open('Account/index.jsp', '_self');
                            }

                        }
                    });
                });
                
                
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
                            window.open('login.jsp', '_self');

                        }
                    });
                });
                
            });
        </script>
    </body>

</html>

<%
        }
    }
%>