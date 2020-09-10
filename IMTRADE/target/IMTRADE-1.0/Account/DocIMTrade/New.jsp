<%@page import="maps.Doctype"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.ArrayList"%>
<div id="prive">
    <%
        String path = request.getServletContext().getRealPath("");
        path += "\\Account\\";
        request.setAttribute("type", "listtemplate");
    %>
    <jsp:include page="/SelectFile" />
    <%
        ArrayList<Doctype> doctypes = (ArrayList<Doctype>) session.getAttribute("doctype");
        //out.print(doctypes.get(0).getAbbrev());
    %>


    <div class="row page-titles">
        <div class="col-md-5 align-self-center">
            <h4 class="text-themecolor">Nouveau</h4>
        </div>
        <div class="col-md-7 align-self-center text-right">
            <div class="d-flex justify-content-end align-items-center">
                <ol class="breadcrumb">
                    <li class="breadcrumb-item"><a href="javascript:void(0)">Document IMTrade</a></li>
                    <li class="breadcrumb-item active">Nouveau</li>
                </ol> 
            </div>
        </div>
    </div>
    <div class="row">
        <div class="col-lg-9 col-xlg-10 col-md-8">
            <div class="card">
                <div class="card-body">
                    <%
                        HashMap<String, ArrayList<String>> templates = (HashMap<String, ArrayList<String>>) session.getAttribute("templates");
                        for (int idx = 0; idx < doctypes.size(); idx++) {
                            Doctype elem = doctypes.get(idx);


                    %>

                    <h4 class="card-title m-t-40" id="<%=idx + 5%>"><%= elem.getNomDocument()%></h4>
                    <br/>
                    <div class="row" style="min-height: 600px;">
                        <div class="col-lg-3">
                            <a class="file" id="<%= elem.getAbbrev()%>-0" href="javascript:void(0)">
                                <div  class="card">
                                    <div class="card-body">
                                        <h6 class="text-center card-title"><%= elem.getAbbrev()%> vièrge</h6>
                                        <embed style="width: 100%;" src="http://localhost:8080/IMTRADE/Account/File/ressources/ds.pdf" type="application/pdf" target="_blank" />

                                    </div>
                                </div>
                            </a>    
                        </div>
                        <%
                        if (templates.containsKey(elem.getNomDocument())) {
                            ArrayList<String> template = templates.get(elem.getNomDocument());
                            //

                            for (int i = 0; i < template.size(); i++) {
                                //System.out.print(elem.getNomDocument()+" "+template.get(0));
                            
                        %>

                        <div class="col-lg-3">
                            <a class="file" id="<%= elem.getAbbrev()+"-"+template.get(i).split("%%")[0]%>" href="javascript:void(0)">
                                <div class="card">
                                    <div class="card-body">
                                        <h6 class="text-center card-title"><%=template.get(i).split("%%")[1]%></h6>
                                        <embed style="width: 100%;" src="http://localhost:8080/IMTRADE/Account/File/ressources/ds.pdf" type="application/pdf" target="_blank" />

                                    </div>
                                </div>
                            </a>    
                        </div>

                        <%
                                }
                            }
                        %>                
                    </div>


                    <hr/>
                    <%
                        }
                    %>



                </div>
            </div>
        </div>
        <div class="col-lg-3 col-xlg-2 col-md-4">
            <div class="stickyside">
                <div class="list-group" id="top-menu">
                    <%
                        for (int idx = 0; idx < doctypes.size(); idx++) {
                            Doctype elem = doctypes.get(idx);
                    %>
                    <a href="#<%=idx + 5%>" class="list-group-item "><%= elem.getNomDocument()%></a>
                    <%
                        }
                    %>

                </div>
            </div>
        </div>
    </div>

    <script src="../../assets/node_modules/raphael/raphael-min.js"></script>
    <script src="../../assets/node_modules/morrisjs/morris.min.js"></script>
    <script src="../../assets/node_modules/jquery-sparkline/jquery.sparkline.min.js"></script>

    <script src="../../assets/node_modules/toast-master/js/jquery.toast.js"></script>
    <script src="../../assets/node_modules/sticky-kit-master/dist/sticky-kit.min.js"></script>
    <script src="../../assets/node_modules/sparkline/jquery.sparkline.min.js"></script>

    <script>

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

