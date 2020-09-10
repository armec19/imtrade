<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.io.File"%>
<%@page import="java.util.Comparator"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.Collections"%>
<%@page import="maps.Produit"%>
<%@page import="module.ModelBean"%>
<%@page import="java.util.List"%>
<%
    String appPath = request.getServletContext().getRealPath("");

    String savePath ="http://localhost:8080/IMTRADE//webfiles//images//";
    File fileDir = new File(savePath);
    if (!fileDir.exists()) {
        fileDir.mkdirs();
    }
%>
<style>

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
    .pagination{
        background:#ffffff;
        padding: 1rem;
        margin: 3rem auto;
        border-radius: 0.2rem;
        box-shadow: 0 4px 6px 0 rgba(0, 0, 0, 0.3);
        counter-reset: pagination;
        text-align: center;
        width: 14rem;
    }
    button .prev,next::hover {

        background-color: black;
        border: solid 1px black;

    }






</style>

<!-- ============================================================== -->
<!-- End Left Sidebar - style you can find in sidebar.scss  -->
<!-- ============================================================== -->
<!-- ============================================================== -->
<!-- Page wrapper  -->
<!-- ============================================================== -->

<!-- ============================================================== -->
<!-- Container fluid  -->
<!-- ============================================================== -->

<!-- ============================================================== -->
<!-- Bread crumb and right sidebar toggle -->
<!-- ============================================================== -->

<!-- ============================================================== -->
<!-- End Bread crumb and right sidebar toggle -->
<!-- ============================================================== -->
<!-- ============================================================== -->
<!-- Start Page Content -->
<!-- ============================================================== -->
<div class="row page-titles">
    <div class="col-md-5 align-self-center">
        <h4 class="text-themecolor">Consulter Stock</h4>
    </div>
    <div class="col-md-7 align-self-center text-right">
        <div class="d-flex justify-content-end align-items-center">
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href="javascript:void(0)">Le Stock</a></li>
                <li class="breadcrumb-item active">Consulter Stock</li>

            </ol> 
        </div>
    </div>

</div>

<div id="container2">


</div> 


<div class="con" id="con">


    <div class="row">
        <div class="col-sm-6">
            <div class="search-input">
                <input type="text" class="search" onkeyup="myFunction1()" id="myInput">
                <span class="highlight"></span>
                <span class="bar"></span>
                <label>Search here</label>
                <span class="glyphicon glyphicon-search"></span>
                <span class="glyphicon glyphicon-remove"></span>
            </div>
        </div>
    </div>        







    <div class="row el-element-overlay" id="gallery-items" >

        <%
            List<Produit> listProduit = (List<Produit>) request.getAttribute("produit");

            Collections.sort(listProduit, new Comparator<Produit>() {
                @Override
                public int compare(Produit u1, Produit u2) {

                    return u1.getUtilise() > u2.getUtilise() ? 1 : u1.getUtilise() < u2.getUtilise() ? -1 : 0;
                }

            });


        %>
        <% for (int i = listProduit.size() - 1; i >= 0; i--) { %> 
        <% if (i < listProduit.size() && i >= 0) {%>

        <div class="col-lg-3 col-md-6 item" id="item">
            <div class="card">
                <div class="el-card-item">
                    <div class="el-card-avatar el-overlay-1" style="height:250px;">
                        <img src=" <%= savePath+listProduit.get(i).getImage()%>"  alt="user"  />
                        <div class="el-overlay">
                            <ul class="el-info">
                                <li>
                                    <a class="btn default btn-outline image-popup-vertical-fit" href="<%= savePath+listProduit.get(i).getImage()%>">
                                        <i class="icon-magnifier"></i>
                                    </a>
                                </li>
                                <li>
                                    <a class="btn default btn-outline detail-Produit" id="<%= listProduit.get(i).getIdProduit()%>" >
                                        <i class="icon-link" ></i>
                                    </a>
                                </li>
                            </ul>
                        </div>
                    </div>
                    <div class="el-card-content" style="height:50px;">
                        <h4 class="box-title"><%= listProduit.get(i).getNomProduit()%></h4>


                        <br/> </div>
                </div>
            </div>
        </div>

        <% } %>
        <% }%>


    </div>
    <div class="pagination" style="width: 280px;padding:15px;text-align: center; margin-left:400px;">
        <button type="button" class="btn waves-effect waves-light btn-outline-dark prev" style="width:90px;margin-left:10px; margin-right:3px;">Previous</button>
        <button type="button" class="btn waves-effect waves-light btn-dark" style="width:auto;margin-right:3px;margin-left:3px;"><span class="page-num">1</span></button>
        <button type="button" class="btn waves-effect waves-light btn-outline-dark next" style="width:90px;margin-left:3px;margin-right:10px;">Next</button>
    </div>


</div>


<script src="../assets/node_modules/Magnific-Popup-master/dist/jquery.magnific-popup.min.js"></script>
<script src="../assets/node_modules/Magnific-Popup-master/dist/jquery.magnific-popup-init.js"></script>
<script>
                    function myFunction1() {
// Declare variables

                        var input, filter, ul, li, a, i, txtValue, list;
                        input = document.getElementById('myInput');
                        filter = input.value.toUpperCase();
                        li = document.getElementsByClassName("col-md-6");


// Loop through all list items, and hide those who don't match the search query
                        for (i = 0; i < li.length; i++) {
                            a = li[i].getElementsByClassName("box-title")[0];
                            txtValue = a.textContent || a.innerText;
                            if (txtValue.toUpperCase().indexOf(filter) > -1) {

                                li[i].style.display = "";
                            } else {
                                li[i].style.display = "none";
                            }
                        }
                    }
</script> 
<script>

    const galleryItems = document.querySelector("#gallery-items").children;
    const prev = document.querySelector(".prev");
    const next = document.querySelector(".next");
    const page = document.querySelector(".page-num");
    const maxItem = 12;
    let index = 1;

    const pagination = Math.ceil(galleryItems.length / maxItem);


    prev.addEventListener("click", function () {
        if (index > 1) {
            index--;
            check();
            showItems();
        }
    })
    next.addEventListener("click", function () {
        if (index < pagination) {
            index++;
            check();
            showItems();
        }
    })

    function check() {
        if (index == pagination) {
            next.classList.add("disabled");
        } else {
            next.classList.remove("disabled");
        }

        if (index == 1) {
            prev.classList.add("disabled");
        } else {
            prev.classList.remove("disabled");
        }
    }

    function showItems() {
        for (let i = 0; i < galleryItems.length; i++) {
            galleryItems[i].classList.remove("show");
            galleryItems[i].classList.add("hide");


            if (i >= (index * maxItem) - maxItem && i < index * maxItem) {
                // if i greater than and equal to (index*maxItem)-maxItem;
                // means  (1*8)-8=0 if index=2 then (2*8)-8=8
                galleryItems[i].classList.remove("hide");
                galleryItems[i].classList.add("show");
            }
            page.innerHTML = index;
        }


    }

    window.onload = function () {
        showItems();
        check();
    }


</script> 