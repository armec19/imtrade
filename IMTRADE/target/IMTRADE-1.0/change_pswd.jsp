<%-- 
    Document   : change
    Created on : 25 juin 2020, 10:23:00
    Author     : Mechri
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
    if ((request.getParameter("Email") == null) || (request.getParameter("Email") == "") || (request.getParameter("Hashuser") == null) || (request.getParameter("Hashuser") == "")) {
        //String url = (String) session.getAttribute("login.jsp");

        response.sendRedirect("login.jsp");
    } else {

        String email = (String) request.getParameter("Email");
        String hash = (String) request.getParameter("Hashuser");

%>
<jsp:include page="AccountManager" />


<html lang="en">

    <head>
        <jsp:include page="out_header.jsp"/>

    </head>

    <body>

        <div class="preloader">
            <div class="loader">
                <div class="loader__figure"></div>
                <p class="loader__label">Imanage</p>
            </div>
        </div>

        <section id="wrapper">
            <div class="login-register" style="background-image:url(assets/images/background/login-register.jpg);">
                <div class="login-box card">
                    <div class="card-body">

                        <form class="form-horizontal form-material" id="loginform" novalidate>
                            <h3 class="text-center box-title m-b-20">Nouveau mot de passe</h3>
                            <p class="text-center text-info">${mail}</p>
                            <input type="hidden" name="email" id="email" value="${mail}" />
                            <div class="form-group">
                                <h5>Mot de passe <span class="text-danger">*</span></h5>
                                <div class="controls">
                                    <input type="password" name="password" id="password" class="form-control" placeholder="Mot de passe" required="true" data-validation-required-message="Ce champ est obligatoire"> 
                                </div>
                            </div>
                            <div class="form-group">
                                <h5>Verification <span class="text-danger">*</span></h5>
                                <div class="controls">
                                    <input type="password" name="password2" id="password2" data-validation-match-match="password" placeholder="Verification" class="form-control" required="true" data-validation-required-message="Ce champ est obligatoire">
                                </div>
                            </div>
                            <div class="form-group text-center p-b-10">
                                <div class="col-xs-12">
                                    <button class="btn btn-info btn-lg btn-block text-uppercase waves-effect waves-light reset" type="submit">Reset</button>
                                </div>
                            </div>
                        </form>

                    </div>
                </div>
            </div>
        </section>

        <jsp:include page="out_footer.jsp"/>
        <script src="dist/js/pages/validation.js"></script>
        <script>
            !function (window, document, $) {
                "use strict";
                $("input,select,textarea").not("[type=submit]").jqBootstrapValidation();
            }(window, document, jQuery);

            $(document).ready(function () {
                $(document).on("click", ".reset", function (event) {

                    event.preventDefault();
                    
                    if ($("#password").val().length > 5 && $("#password").val() == $("#password2").val()) {
                       $('.preloader').show();
                        $.ajax({
                            url: '/IMTRADE/AccountManager',
                            method: "POST",
                            data: {
                                mail: $("#email").val(),
                                hash: '<%= hash%>',
                                password: $("#password").val(),
                                type: "reset"
                            },
                            success: function (data) {
                                $('.preloader').hide();
                                window.open('login.jsp', '_self');
                            }
                        });
                    }
                });
            });
        </script>
    </body>

</html>
<%        }
%>