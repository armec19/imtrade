<%@page import="java.io.File"%>
<%@page import="maps.Doctype"%>
<%@page import="maps.Document"%>
<%@page import="maps.DocObjet"%>
<%@page import="maps.DocObjetSn"%>
<%@page import="maps.Structure"%>
<%@page import="maps.Structure"%>
<%@page import="module.ModelBean"%>
<%@page import="maps.Projet"%>
<%@page import="java.util.List"%>
<%@page import="maps.Serialnumber"%>
<%@page import="maps.Objet"%>
<%@page import="maps.Produit"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    String appPath = request.getServletContext().getRealPath("");

    //String savePath = appPath + "\\webfiles\\images\\";
    String savePath ="http://localhost:8080/IMTRADE//webfiles//images//";
    File fileDir = new File(savePath);
    if (!fileDir.exists()) {
        fileDir.mkdirs();
    }
%>


<style>
    #container{

        margin-top:50px;
        margin-bottom:10px;
        padding: 15px 15px 50px;
        background-color: white;
        box-shadow: 0 1px 3px rgba(34, 25, 25, 0.4);
        -moz-box-shadow: 0 1px 2px rgba(34,25,25,0.4);
        -webkit-box-shadow: 0 1px 3px rgba(34, 25, 25, 0.4);
        width:1000px

    }

    .col-md-7{
        color:#555;



    }

    .price{
        color:#FE980F;
        font-size:26px;
        font-weight:bold;

    }
    .imgBorder {
        padding: 15px 15px 0;
        background-color: white;
        box-shadow: 0 1px 3px rgba(34, 25, 25, 0.4);
        -moz-box-shadow: 0 1px 2px rgba(34,25,25,0.4);
        -webkit-box-shadow: 0 1px 3px rgba(34, 25, 25, 0.4);
    }

    input{
        border:1px solid #ccc;
        font-weight:bold;
        height:33px;
        text-align:center;
        width:30px;

    }
    .img-pro1{
        width:100%;
        height:300px;

        padding:5px 5px 5px 5px;
    } 
    *,
    *::before,
    *::after {
        box-sizing: border-box;
    }
    .search-input {
        position: relative;
        padding: 1rem 0 0.5rem 0;
        height: 6rem;
        width: 22.5rem;
    }

    .search-input input {
        border: none;
        border-bottom: 1px solid rgba(0,0,0,1);
        display: block;
        font-size: 1rem;
        line-height: 1rem;
        margin: 0;
        padding: 0.5rem 0;
        width: 100%;
        text-align: left; 
        background-color: transparent;
        color: rgba(0,0,0,1);
    }

    .search-input input:focus {
        outline: none;
    }

    .search-input label {
        position: absolute;
        left: 0;
        top: 1.625rem;
        width: 100%;
        color: rgba(0,0,0,.3);
        font-size: 1rem;
        line-height: 1rem;
        font-weight: normal;
        pointer-events: none;
        transition: 0.2s ease all;
        -moz-transition: 0.2s ease all;
        -webkit-transition: 0.2s ease all;
    }

    .search-input input:focus ~ label {
        top: 0;
        font-size: 0.75rem;
        color: rgba(0,0,0,1);
    }

    .search-input label.not-empty {
        top: 0;
        font-size: 0.75rem;
    }

    .search-input span:nth-of-type(3) {
        position: absolute;
        color: rgba(0,0,0,1);
        left: 100%;
        top: 1.625rem;
        font-size: 1rem;
        transition: 0.2s ease all;
        -moz-transition: 0.2s ease all;
        -webkit-transition: 0.2s ease all;
    }

    .search-input input:focus ~ span:nth-of-type(3) {
        left: -1.625rem;
        top: 1.625rem;
        color: rgba(0,0,0,1);
    }

    .search-input span:nth-of-type(3).not-empty {
        left: -1.625rem !important;
        top: 1.625rem !important;
    }

    .search-input span:nth-of-type(4) {
        position: absolute;
        color: rgba(0,0,0,1);
        right: 0;
        top: 1.625rem;
        font-size: 1rem;
        opacity: 0;
        transition: 0.2s ease all;
        -moz-transition: 0.2s ease all;
        -webkit-transition: 0.2s ease all;
    }

    .search-input input:focus ~ span:nth-of-type(4) {
        color: rgba(0,0,0,1);
        opacity: 1;
        cursor: pointer;
    }

    .search-input span:nth-of-type(4).not-empty {
        opacity: 1 !important;
    }

    .search-input .bar {
        display: block;
        width: 0;
        margin-left: 50%;
        height: 1px;
        background: rgba(0,0,0,1);
        opacity: 0;
        transition: 0.2s ease all;
        -moz-transition: 0.2s ease all;
        -webkit-transition: 0.2s ease all;
    }

    .search-input input:focus ~ .bar {
        opacity: 1;
        width: 100%;
        margin-left: 0;
    }

    .modal1 {
        display: none; /* Hidden by default */
        position: fixed; /* Stay in place */
        z-index: 1; /* Sit on top */
        padding-top: 100px; /* Location of the box */
        left: 0;
        top: 0;
        width: 100%; /* Full width */
        height: 100%; /* Full height */
        overflow: auto; /* Enable scroll if needed */
        background-color: rgb(0,0,0); /* Fallback color */
        background-color: rgba(0,0,0,0.4); /* Black w/ opacity */
    }
    .modal1 .modal-body, .modal1 .modal-footer {
        padding: 20px 30px;
    }
    .modal1 .modal-footer {
        background: #fff;
        border-radius: 0 0 1px 1px;
    }
    .modal-content1 .modal-title {
        display: inline-block;
        color:#514151;
        font-size: 2rem;
        font-family: 'Slabo 27px', serif;
        font-weight: 100;
        margin: 0;
        border-radius: 1px;


    }
    .modal1 .form-control {
        border-radius: 1px;
        box-shadow: none;
        border-color: #dddddd;
    }
    .modal1 textarea.form-control {
        resize: vertical;
    }
    .modal1 .btn {
        border-radius: 1px;
        min-width: 100px;
    } 
    .modal1 label {
        font-weight: normal;
        font-size: 20px;
    } 
    .modal1 input,.modal1 select {
        font-weight: normal;
        font-size: 17px;
        height:auto;
    } 


    /* Modal Content */
    .modal-content1 {
        background-color: #fefefe;
        border-radius: 1px;
        margin-left: 380px;


        width: 50%;
        height: auto;

    }
    .modal-content2 {
        background-color: #fefefe;
        border-radius: 1px;
        margin-left: 350px;

        width: 60%;
        height: auto;

    }

    /* The Close Button */
    .close {
        color: #aaaaaa;
        float: right;
        font-size: 28px;
        font-weight: bold;
    }

    .close:hover,
    .close:focus {
        color: #000;
        text-decoration: none;
        cursor: pointer;
    }

    .img-det:hover{
        transform: scale(1.5); 
    }


</style>
<div id="container" class="container" >


    <%

        Produit produit = (Produit) request.getAttribute("produit");
        Objet objet = (Objet) request.getAttribute("objet");
        Structure structure = (Structure) ModelBean.GetContentTable("Structure", "WHERE id_structure=" + objet.getIdStructure()).get(0);

        List<Serialnumber> serial = (List<Serialnumber>) request.getAttribute("serial");
        //List<Serialnumber> serial_all=(List<Serialnumber>)request.getAttribute("serialall");
        //List<Projet> projet=(List<Projet>)request.getAttribute("projet");
        String etat = "Stock";
    %>

    <div class="row" >

        <div class="col-md-5" style="padding-left:120px;" >





            <a  type="button" class="imgp" ><img src="<%= savePath+produit.getImage()%>" width="300" height="250" /></a>







        </div>

        <div class="col-md-7" style="padding-left:40px;">
            <h4 style="font-size: 16px;"><%= produit.getTypeProduit()%>-<%= produit.getModele()%>-<%= produit.getMarque()%></h4>
            <h4 style="color: #337ab7;font-size: 17px;font-weight: 600;"><%= produit.getNomProduit()%>/<%= produit.getDesignation()%></h4>
            <h4 style="font-size: 16px;">Prix Unitaire</h4>
            <h4 style="color_:#1d7d1c;color:rgb(189, 9, 38);font-size:17px;font-weight: 600;"><%= produit.getPrix()%> DZ </h4>



            <label style="font-size: 17px;">Quantité:</label>
            <input style="font-size:20px;width:65px;" type="text" id="qte" value="<%= produit.getQuantite()%>">


            <div style="margin:15px 0;">
                <a style="font-weight:600;margin-bottom:5px;margin-right:5px;" id="filtrageProduit" class="btn waves-effect waves-light btn-outline-secondary" title="TYPE" ><i style="padding-right:5px;color:#59b200;" class="fa fa-tag" aria-hidden="true"></i><b><%= produit.getTypeProduit()%></b></a> 
                <a style="font-weight:600;margin-bottom:5px;margin-right:5px;" id="filtrageProduit" class="btn waves-effect waves-light btn-outline-secondary" title="MARQUE" ><i style="padding-right:5px;color:#59b200;" class="fa fa-tag" aria-hidden="true"></i><b><%= produit.getMarque()%></b></a>
                <a style="font-weight:600;margin-bottom:5px;margin-right:5px;" id="filtrageProduit" class="btn waves-effect waves-light btn-outline-secondary" title="STRUCTURE" ><i style="padding-right:5px;color:#59b200;" class="fa fa-tag" aria-hidden="true"></i><b id="<%= structure.getIdStructure()%>"><%= structure.getNomStructure()%></b></a>   


            </div>
            <button id="cons" type="button" class="btn btn-default cart" style=" background:#FE980F;color:#ffffff;font-size:15px;margin-left:0px;">
                Return To Stock</button>

        </div>
        <div class="col-md-12" style="margin-top:100px;">




            <div class="table-wrapper" id="myTable1">
                <div class="table-title1" style="background: #ffffff">
                    <div class="row">
                        <div class="col-sm-6">
                            <h2 style="text-align: center;"> Listes de Produits</h2>
                        </div>

                        <div class="col-sm-6">
                            <div class="search-input">
                                <input type="text" class="search">
                                <span class="highlight"></span>
                                <span class="bar"></span>
                                <label>Search here</label>
                                <span class="glyphicon glyphicon-search"></span>
                                <span class="glyphicon glyphicon-remove"></span>
                            </div>
                        </div>

                        <div class="col-sm-6" style="margin-top:10px;">


                        </div>
                    </div>
                </div>

                <table class="table" id="myTable1">
                    <thead>
                        <tr class="table-head" >
                            <th class="table-cell align-right sort" data-sort="index">#</th>
                            <th class="table-cell align-left sort"  data-sort="s1">SerialNumber</th>
                            <th class="table-cell align-left sort" data-sort="e1">Etat</th>
                            <th class="table-cell align-left sort" data-sort="d1">DateRevenu</th>
                            <th class="table-cell align-left">Actions</th>

                        </tr>
                    </thead>

                    <tbody class="list">
                        <% for (int i = 0; i < serial.size(); i++) {%> 
                        <tr class="table-row" id="<%= serial.get(i).getIdSn()%>"> 

                            <td class="table-cell align-right" id="index"><%= i + 1%></td> 


                            <td class="table-cell align-left s1" id="s1"><%= serial.get(i).getSn()%></td>


                            <td class="table-cell align-left e1" id="e1"><%= serial.get(i).getEtatSn()%></td>  

                            <td class="table-cell align-left d1" id="d1"><%= serial.get(i).getDateRevenu()%></td> 

                            <td class="table-cell align-center">  <a  id="<%= serial.get(i).getIdSn()%>" class="voir-serial"> <i class="material-icons" id="">visibility</i> </a>  


                            </td> 





                        </tr>
                        <% }%> 

                    </tbody>
                </table>


                <!-- /#no-results -->
            </div>


        </div>




    </div>


</div>



<div class="modal" id="detailProduit" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true" style="display: none;">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title" id="myLargeModalLabel">Detail Produit</h4>
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
            </div>




            <!-- Nav tabs -->
            <ul class="nav nav-tabs customtab" role="tablist">
                <li class="nav-item"> <a class="nav-link active" data-toggle="tab" href="#general" role="tab"><span class="hidden-sm-up"></span> <span class="hidden-xs-down">General</span></a> </li>
                <li class="nav-item"> <a class="nav-link" data-toggle="tab" href="#projet" role="tab"><span class="hidden-sm-up"></span> <span class="hidden-xs-down">Projet</span></a> </li>
                <li class="nav-item"> <a class="nav-link" data-toggle="tab" href="#destinateur" role="tab"><span class="hidden-sm-up"></span> <span class="hidden-xs-down">Destinateur</span></a> </li>
            </ul>
            <!-- Tab panes -->
            <div class="tab-content">
                <div class="tab-pane active" id="general" role="tabpanel">
                    <div class="p-20">
                        <div class="row">
                            <div class="col-md-5">
                                <h4>Serial :</h4>

                            </div> 
                            <div class="col-md-6">
                                <h4 style="color:#f46a4e;" class="serial"></h4>

                            </div> 
                        </div>
                        <div class="row">
                            <div class="col-md-5">
                                <h4>Etat_Produit:</h4>

                            </div> 
                            <div class="col-md-6">
                                <h4 style="color:#f46a4e;" class="etat"></h4>

                            </div> 
                        </div>
                        <div class="row">
                            <div class="col-md-5">
                                <h4>Date_Revenu :</h4>

                            </div> 
                            <div class="col-md-6">
                                <h4 style="color:#f46a4e;" class="date"></h4>

                            </div> 
                        </div>
                        <div class="row">
                            <div class="col-md-5">
                                <h4>Type Document :</4>

                            </div> 
                            <div class="col-md-6">
                                <h4 style="color:#f46a4e;" class="typedocument"></h4>

                            </div> 
                        </div>

                    </div>
                </div>
                <div class="tab-pane  p-20" id="projet" role="tabpanel">
                    <div class="row">
                        <div class="col-md-5">
                            <h4>Projet :</4>

                        </div> 
                        <div class="col-md-6">
                            <h4 style="color:#f46a4e;" class="nom_projet"></h4>

                        </div> 
                    </div>
                    <div class="row">
                        <div class="col-md-5">
                            <h4>Nature :</h4>

                        </div> 
                        <div class="col-md-6">
                            <h4 style="color:#f46a4e;" class="nature"></h4>

                        </div> 
                    </div>
                    <hr>
                    <div class="row">
                        <div class="">
                            <h4 style="color:#f46a4e;" class="">Membre De Projet</h4>
                            <ul class="membre">

                            </ul>

                        </div>
                    </div>










                </div>
                <div class="tab-pane p-20" id="destinateur" role="tabpanel">
                    <div class="row">
                        <div class="col-md-5">
                            <h4>Nom_Destinateur :</h4>

                        </div> 
                        <div class="col-md-6">
                            <h4 style="color:#f46a4e;" class="nom_destinateur">Remadna Mouadh</h4>

                        </div> 
                    </div>
                    <div class="row">
                        <div class="col-md-5">
                            <h4>Type :</h4>

                        </div> 
                        <div class="col-md-6">
                            <h4 style="color:#f46a4e;" class="type_destinateur"></h4>

                        </div> 
                    </div>
                    <div class="row">
                        <div class="col-md-5">
                            <h4>Phone_Destinateur :</h4>

                        </div> 
                        <div class="col-md-6">
                            <h4 style="color:#f46a4e;" class="phone_destinateur"></h4>

                        </div> 
                    </div>
                    <div class="row">
                        <div class="col-md-5">
                            <h4>Email_Destinateur :</h4>

                        </div> 
                        <div class="col-md-6">
                            <h4 style="color:#f46a4e;" class="email_destinateur"></h4>

                        </div> 
                    </div>
                    <div class="row">
                        <div class="col-md-5">
                            <h4>Registre_Commerce :</h4>

                        </div> 
                        <div class="col-md-6">
                            <h4 style="color:#f46a4e;" class="registre_commerce"></h4>

                        </div> 

                    </div>
                    <div class="row">
                        <div class="col-md-5">
                            <h4>N_agrement :</h4>

                        </div> 
                        <div class="col-md-6">
                            <h4 style="color:#f46a4e;" class="n_argument"></h4>

                        </div> 

                    </div>






                </div>
            </div>


            <div class="modal-footer">
                <button type="button" class="btn btn-danger waves-effect text-left" data-dismiss="modal">Close</button>
            </div>
        </div>
        <!-- /.modal-content -->
    </div>
    <!-- /.modal-dialog -->
</div>
<!-- /.modal -->















<div id="historique" class="modal bs-example-modal-lg" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true" style="display: none;">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title" id="myLargeModalLabel">Historique Produit</h4>
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
            </div>
            <div class="modal-body">
                <div class="table-wrapper">


                    <table id="dtBasicExample" class="table table-striped table-bordered table-sm" cellspacing="0" width="100%">
                        <thead>
                            <tr>
                                <th class="th-sm">#

                                </th>
                                <th class="th-sm">Etat

                                </th>
                                <th class="th-sm">Date

                                </th>

                            </tr>
                        </thead>
                        <tbody>

                        </tbody>

                    </table>


                    <!-- /#no-results -->
                </div>


            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-danger waves-effect text-left" data-dismiss="modal">Close</button>
            </div>
        </div>
        <!-- /.modal-content -->
    </div>
    <!-- /.modal-dialog -->
</div>

<div id="updateImage" class="modal" tabindex="-1" role="dialog" aria-labelledby="tooltipmodel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title" id="tooltipmodel">Update Image</h4>
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
            </div>
            <input  id="id1" type="hidden" value="<%= produit.getIdProduit()%>">
            <div class="modal-body">



                <div class="form-group" style="margin-top:20px;">
                    <label for="exampleFormControlFile1">Image</label>
                    <input type="file" class="form-control"    id="image2" name="image">
                </div>

            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default waves-effect" data-dismiss="modal">Close</button>
                <button type="button" class="btn btn-danger waves-effect waves-light save3">Save changes</button>
            </div>
        </div>
        <!-- /.modal-content -->
    </div>
    <!-- /.modal-dialog -->
</div> 



