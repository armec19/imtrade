<%-- 
    Document   : recouver
    Created on : 25 juin 2020, 10:22:24
    Author     : Mechri
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
    if ((session.getAttribute("mailparam") == null) || (session.getAttribute("mailparam") == "") ) {
        //String url = (String) session.getAttribute("login.jsp");
        response.sendRedirect("login.jsp");
    } else {
        String email = (String) session.getAttribute("mailparam");
        session.setAttribute("mailparam",null);
%>
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
                        <h3 class="text-center box-title m-b-20">Verifier votre e-mail</h3>
                        <p class="text-center"><% out.print(email); %></p>
                    </div>
                </div>
            </div>
        </section>
        
        <jsp:include page="out_footer.jsp"/>
        
    </body>

</html>
<%  
    }
%>