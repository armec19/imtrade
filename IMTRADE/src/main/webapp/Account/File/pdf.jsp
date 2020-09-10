<%@page import="maps.Doctype"%>
<jsp:include page="/Content" />
<html lang="en">
    <head>
        <meta charset="utf-8">
        <title>Revue en PDF</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta name="description" content="">
        <meta name="author" content="">

        <!-- Bootstrap -->
        <link href="PDF/examples/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="steps/fonts/material-icon/css/material-design-iconic-font.min.css">
        <link rel="stylesheet" href="steps/css/style.css">


        <!-- Editor CSS -->

        <link href="PDF/examples/css/editor.css" rel="stylesheet">
        <link href="steps/css/select.css" rel="stylesheet">
    </head>

    <body>
        <style>
            .h33:hover{
                color: #6dbdfe;
            }
        </style>
        <div class="row-fluid" style=" margin-top: -20px">
            <div class="span6" style="float: right; height: 93%;width: 100%;" >
                <div id="preview-pane" style="height: 100%;position:relative; z-index:999"></div>
            </div>
            <%
                Doctype doctyped = (Doctype) session.getAttribute("Doctype");

                String pagename = doctyped.getAbbrev();
            %>

            <% if (pagename.equals("BC")) { %>
            <jsp:include page="ressources/textBC.jsp" />
            <% } %>

            <% if (pagename.equals("BE")) { %>
            <jsp:include page="ressources/textBE.jsp" />
            <% } %>

            <% if (pagename.equals("BL")) { %>
            <jsp:include page="ressources/textBL.jsp" />
            <% } %>

            <% if (pagename.equals("BM")) { %>
            <jsp:include page="ressources/textBM.jsp" />
            <% } %>

            <% if (pagename.equals("BRes")) { %>
            <jsp:include page="ressources/textBRes.jsp" />
            <% } %>

            <% if (pagename.equals("BRet")) { %>
            <jsp:include page="ressources/textBRet.jsp" />
            <% } %>

            <% if (pagename.equals("BSit")) { %>
            <jsp:include page="ressources/textBSit.jsp" />
            <% } %>

            <% if (pagename.equals("BSor")) { %>
            <jsp:include page="ressources/textBSor.jsp" />
            <% } %>

            <% if (pagename.equals("DA")) { %>
            <jsp:include page="ressources/textDA.jsp" />
            <% } %>

            <% if (pagename.equals("Fac")) { %>
            <jsp:include page="ressources/textFac.jsp" />
            <% } %>

            <% if (pagename.equals("O")) {%>
            <jsp:include page="ressources/textO.jsp" />
            <% } %>

            <% if (pagename.equals("P")) {%>
            <jsp:include page="ressources/textP.jsp" />
            <% } %>
            <% if (pagename.equals("OM")) {%>
            <jsp:include page="ressources/textOM.jsp" />
            <% }%>
            <% if (pagename.equals("BG")) {%>
            <jsp:include page="ressources/textBG.jsp" />
            <% }%>
            <div id="editor" class="bypass" style="display:none;"></div>

            <div class="controls" style="display:none;">
                <div class="pull-right">
                    <!--<a href="#" class="btn btn-primary">Download Your Code</a>-->
                    <a href="#" class="btn btn-primary download-pdf">Download PDF</a>
                </div>

                <label class="checkbox">
                    <input type="checkbox" id="auto-refresh" checked="checked"> Auto refresh on changes?
                </label>

                <div class="alert hide">
                    Auto refresh disabled for this
                </div>

            </div>

        </div>
        <div class="clerfix"></div>	

        <script   src="PDF/examples/js/jquery/jquery-1.7.1.min.js"></script>

        <script type="text/javascript">
            $(document).ready(function () {
                if (jsPDF && jsPDF.version) {
                    $('#dversion').text('Version ' + jsPDF.version);
                }
            });
        </script>

        <!-- Code editor -->
        <script src="steps/css/chiffreenlettre.js" type="text/javascript" charset="utf-8"></script>
        <script src="PDF/examples/js/ace.js" type="text/javascript" charset="utf-8"></script>

        <!-- Scripts in development mode -->
        <script type="text/javascript" src="PDF/dist/jspdf.debug.js"></script>		
        <script src="PDF/libs/faker.min.js"></script>
        <script src="PDF/libs/jspdf.plugin.autotable.js"></script>
        <script type="text/javascript" src="PDF/examples/js/pdfobject.min.js"></script>
        <script type="text/javascript" src="PDF/examples/js/editor.js"></script>

    </body>
</html>
