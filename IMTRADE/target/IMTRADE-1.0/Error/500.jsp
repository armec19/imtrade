<%-- 
    Document   : 500
    Created on : 26 juil. 2020, 12:07:45
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
        <link rel="icon" type="image/png" sizes="16x16" href="../dist/favicon.png">
        <title>page 500</title>

        <!-- Custom CSS -->
        <link href="../dist/css/style.min.css" rel="stylesheet">
        <!-- page css -->
        <link href="../dist/css/pages/error-pages.css" rel="stylesheet">
    </head>

    <body class="skin-default fixed-layout">

        <section id="wrapper" class="error-page" >
            <div class="error-box" style="background: url(../assets/images/background/error-bg.jpg) no-repeat center center #fff;">
                <div class="error-body text-center">
                    <h1>500</h1>
                    <h3 class="text-uppercase">Erreur de serveur interne !</h3>
                    <p class="text-muted m-t-30 m-b-30">Veuillez essayer après un certain temps</p>
                    <a href="javascript:void(0)" class="btn btn-info btn-rounded waves-effect waves-light m-b-40 retour">Retour à la page d'accueil</a> </div>

            </div>
        </section>
        <script src="../assets/node_modules/jquery/jquery-3.2.1.min.js"></script>
        <!-- Bootstrap tether Core JavaScript -->
        <script src="../assets/node_modules/popper/popper.min.js"></script>
        <script src="../assets/node_modules/bootstrap/dist/js/bootstrap.min.js"></script>
        <!--Wave Effects -->
        <script src="../dist/js/waves.js"></script>

        <script type="text/javascript">
            $(document).ready(function () {
                $(document).on("click", ".retour", function (event) {
                    window.open('../Account/index.jsp', '_self');
                });

            });
        </script>
    </body>

</html>