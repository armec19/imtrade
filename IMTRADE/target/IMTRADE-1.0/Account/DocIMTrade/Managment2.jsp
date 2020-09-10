<script src="../assets/node_modules/jquery/jquery-3.2.1.min.js"></script> 

<script>
    $( document ).ready(function() {
        alert( "document loaded" );
    });
 
   
    </script>

<div id="prive">
    <div class="row page-titles">
        <div class="col-md-5 align-self-center">
            <h4 class="text-themecolor">Parametrage</h4>
        </div>
        <div class="col-md-7 align-self-center text-right">
            <div class="d-flex justify-content-end align-items-center">
                <ol class="breadcrumb">
                    <li class="breadcrumb-item"><a href="javascript:void(0)">Document IMTrade</a></li>
                    <li class="breadcrumb-item active">Parametrage</li>
                </ol> 
            </div>
        </div>
    </div>
    <div class="row">
        <div class="col-lg-9 col-xlg-10 col-md-8">
            <div class="card">
                <div class="card-body">
                    <!--<h4 class="card-title" id="1">Projets</h4>-->
                    
                 
                    <div class="row"  id="1" style="min-height: 600px;">
                        <%
                        request.setAttribute("tablemanage","Projet");
                        %>
                        <jsp:include page="../Model/tablemodal.jsp" />
                    </div>
                     <div class="row"  id="2" style="min-height: 600px;">
                        <%
                        request.setAttribute("tablemanage","Structure");
                        %>
                        <jsp:include page="../Model/tablemodal.jsp" />
                    </div>
                     <div class="row"  id="3" style="min-height: 600px;">
                        <%
                        request.setAttribute("tablemanage","ModeLivraison");
                        %>
                        <jsp:include page="../Model/tablemodal.jsp" />
                    </div>
                     <div class="row"  id="4" style="min-height: 600px;">
                        <%
                        request.setAttribute("tablemanage","ModeReglement");
                        %>
                        <jsp:include page="../Model/tablemodal.jsp" />
                    </div>
                     <div class="row"  id="5" style="min-height: 600px;">
                        <%
                        request.setAttribute("tablemanage","Utilisateur");
                        %>
                        <jsp:include page="../Model/tablemodal.jsp" />
                    </div>
                    

                    
                    
                    
                </div>
            </div>
        </div>
        <div class="col-lg-3 col-xlg-2 col-md-4">
            <div class="stickyside">
                <div class="list-group" id="top-menu">
                    <a href="#1" class="list-group-item active">Projets</a>
                    <a href="#3" class="list-group-item">Natures</a>
                    <a href="#4" class="list-group-item">Types</a>
                    <a href="#5" class="list-group-item">Designations</a>
                    <a href="#6" class="list-group-item">Clients</a>
                    <a href="#7" class="list-group-item">Fournisseurs</a>
                    <a href="#8" class="list-group-item">Articles</a>
                    <a href="#9" class="list-group-item">Type des documents</a>
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
</div>                    

