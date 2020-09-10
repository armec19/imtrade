<div id="prive">
    <div class="row page-titles">
        <div class="col-md-5 align-self-center">
            <h4 class="text-themecolor">Consulter stock</h4>
        </div>
        <div class="col-md-7 align-self-center text-right">
            <div class="d-flex justify-content-end align-items-center">
                <ol class="breadcrumb">
                    <li class="breadcrumb-item"><a href="javascript:void(0)">Le stock</a></li>
                    <li class="breadcrumb-item active">Consulter stock</li>
                      <li class="breadcrumb-item">
                       <div class="btn-group" id="modeStock">
                                                    <button type="button" class="btn btn-danger dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                                        Mode D'affichage
                                                    </button>
                                                    <div class="dropdown-menu">
                                                        
                                                        <a class="dropdown-item" id="modeProduit">Mode2</a>
                                                       
                                                    </div>
                                                </div> 
                    </li>
                </ol> 
            </div>
        </div>
    </div>
    <div class="row">
        <div class="col-lg-12">
            <div class="card">
                <div class="card-body" >
                   <%
                        request.setAttribute("tablemanage","Produit");
                        %>
                        <jsp:include page="../Model/tablemodal.jsp" />
                </div>
            </div>
        </div>
    </div>
</div>