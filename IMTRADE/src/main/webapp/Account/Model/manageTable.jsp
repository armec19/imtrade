
<%@page import="java.util.Comparator"%>
<%@page import="java.util.Collections"%>
<%@page import="maps.Structure"%>
<%@page import="maps.Objet"%>
<%@page import="module.ModelBean"%>
<%@page import="maps.Produit"%>
<%@page import="java.util.List"%>
<%@page import="maps.Utilisateur"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<script>
    var checkbox;
    <%    Utilisateur utilisateur = (Utilisateur) session.getAttribute("Utilisateur");
    String role = utilisateur.getRole();%>
    var tablename = "Produit";
    var variable = ["Material", "Designation", "Matricule", "Type", "Marque", "Modele", "Prix-unitaire", "Structure", "Image"];
    var variableTable = ["Material", "Marque", "Modele", "Quantité", "Prix-unitaire", "Structure"];
    var variableTableAutre = ["Type", "Matricule", "Designation"];
    var variableEdit = ["Material", "Marque", "Modele", "Prix-unitaire", "Structure"];




    $(document).on("click", ".detail-" + tablename, function () {

        $("#con").hide();
        var id = $(this).attr("id");

        $('#container2').load('/IMTRADE/Manager?id=' + id + '&type=' + 'detail' + tablename + '&table=' + tablename);

    });


    'use strict';

    $(function () {

        $('.search-input input').blur(function () {

            if ($(this).val()) {
                $(this)
                        .find('~ label, ~ span:nth-of-type(n+3)')
                        .addClass('not-empty');
            } else {
                $(this)
                        .find('~ label, ~ span:nth-of-type(n+3)')
                        .removeClass('not-empty');
            }
        });

        $('.search-input input ~ span:nth-of-type(4)').click(function () {
            $('.search-input input').val('');
            $('.search-input input')
                    .find('~ label, ~ span:nth-of-type(n+3)')
                    .removeClass('not-empty');
        });

        console.log('Hello from console!');

    });






    var modal = document.getElementById("edit" + tablename);
    $(document).on("click", "#closeedit", function () {

        modal.style.display = "none";
    });
    $(document).on("click", "#mode" + tablename, function () {

        switch ($(this).text()) {
            case "Mode1":


                var id = $(this).parents("td").attr("id");

                //$('#body_content').load('DocIMTrade/Archive.jsp');


                break;
            case "Mode2":

                $('#body_content').load('/IMTRADE/Manager?table=' + tablename + '&type=cardProduit' + '&cond=all');


                break;
        }

    });




    $(document).on("click", "#manage" + tablename, function () {
        switch ($(this).text()) {
            case "VOIR":

                /*jQuery.noConflict(); 
                 $('#fafa').modal('show'); */


                $("#con").hide();
                var id = $(this).parents("td").attr("id");
                //alert(id);
                $('#container2').load('/IMTRADE/Manager?id=' + id + '&type=' + 'detail' + tablename + '&table=' + tablename);

                break;
            case "ÉDITER":
                var v1;
                for (i = 0; i < variableEdit.length; i++) {
                    v1 = $(this).parents("tr").find(".row-" + tablename + "-" + variableEdit[i]).text();

                    $('#edit' + tablename).find('#' + variableEdit[i] + '-' + tablename).val(v1);

                }
                for (i = 0; i < variableTableAutre.length; i++) {
                    v1 = $(this).parents("tr").find("#row-" + tablename + "-" + variableTableAutre[i]).val();

                    $('#edit' + tablename).find('#' + variableTableAutre[i] + '-' + tablename).val(v1);

                }


                $('#edit' + tablename).find('.id-' + tablename).val($(this).parents("tr").find(".row-" + tablename + "-" + variableTable[0]).attr("id"));
                $('#edit' + tablename).find('.line-' + tablename).val($(this).parents("tr").attr("id"));
                modal.style.display = "block";
                break;

            case "EFFACER":


                Swal.fire({
                    title: 'Are you sure?',
                    text: "voulez-vous supprimer!",
                    icon: 'warning',
                    showCancelButton: true,
                    confirmButtonColor: '#3085d6',
                    cancelButtonColor: '#d33',
                    cancelButtonText: 'Annuler',
                    confirmButtonText: 'Supprimer!'
                }).then((result) => {
                    if (result.value) {


                        //alert(f.index());


                        var id = $(this).parents("td").attr("id");
                        //alert(id);
                        //alert('mouadh');
                        $.ajax({
                            url: '/IMTRADE/Manager',
                            type: 'POST',
                            data: {
                                'id': id,
                                'type': 'deleteProduit',
                                'table': tablename,
                            },
                            success: function (response) {


                            }
                        });



                        var table = $("#table" + tablename).DataTable();

                        table.row($(this).parents('tr')).remove().draw();

                        Swal.fire(
                                'Deleted!',
                                'Votre produit a ete supprime.',
                                'success'
                                )
                    }
                })

                break;
        }



    });












    var countcheck = 0;
    checkbox = $('table tbody input[type="checkbox"]');
    $("#selectAll" + tablename).click(function ()
    {
        checkbox = $('table tbody input[type="checkbox"]');

        _isChecked = $(this).parents("label").hasClass("is-checked");
        if (_isChecked === false) {
            $(this).parents("label").addClass("is-checked");
            checkbox.each(function (index, element) {
                $(this).prop("checked", true);
                $(this).parents("label").addClass("is-checked");
            });
            //$('table input[type="checkbox"]').prop("checked",true);
            var table = $("#table" + tablename).DataTable();
            var index = table.column(0).data().length;
            $(".deleterow-" + tablename).find("span").text(index + " " + "elements");
    <%if (role.equals("role1")) {%>
            $('.deleterow-' + tablename).removeClass('hidden');
    <% }%>

            countcheck = index;
        } else {

            $(this).parents("label").removeClass("is-checked");
            checkbox.each(function (index, element) {
                $(this).prop("checked", false);
                $(this).parents("label").removeClass("is-checked");
            });

            $(".deleterow-" + tablename).find("span").text(0 + " " + "elements");
            $('.deleterow-' + tablename).addClass('hidden');
            countcheck = 0;
        }

    });
    $(document).on("click", "#selectone" + tablename + "", function () {

        var er;
        var count = 0;
        if ($(this).parents("label").hasClass("is-checked")) {
            $(this).parents("label").removeClass("is-checked");

            countcheck--;



        } else {
            // var er=$(".delete"+tablename).find("span").text();


            $(this).parents("label").addClass("is-checked");

            countcheck++;

        }
        if (countcheck === 0)
            $('.deleterow-' + tablename).addClass('hidden');
        else
    <%if (role.equals("role1")) {%>
        $('.deleterow-' + tablename).removeClass('hidden');
    <% }%>


        $(".deleterow-" + tablename).find("span").text(countcheck + " " + "elements");


    });


    /*$(document).on("click", "#selectArchive", function() {
     alert("fffff");
     var _tableRow = $(this).parents("tr:first");
     if (_tableRow.hasClass("is-selected") === false) {
     _tableRow.addClass("is-selected");
     } else {
     _tableRow.removeClass("is-selected");
     }
     
     });
     
     $(document).on("click", "#selectAllArchive", function() {
     alert("fffff");
     var _tableRow = $(this).parents("tr:first");
     _isChecked =_tableRow.hasClass("is-selected");
     if (_isChecked === false) {
     _tableRow.addClass("is-selected");
     
     } else {
     _tableRow.removeClass("is-selected");
     
     }
     
     });*/

    $(document).on("click", ".deleterow-" + tablename, function () {
        Swal.fire({
            title: 'Are you sure?',
            text: "voulez-vous supprimer!",
            icon: 'warning',
            showCancelButton: true,
            confirmButtonColor: '#3085d6',
            cancelButtonColor: '#d33',
            cancelButtonText: 'Annuler',
            confirmButtonText: 'Supprimer!'
        }).then((result) => {
            if (result.value) {


                //alert(f.index());
                checkbox.each(function (index, element) {
                    if ($(this).parents("label").hasClass("is-checked")) {

                        var id = $(this).parents("td").attr("id");


                        $.ajax({
                            url: '/IMTRADE/Manager',
                            type: 'POST',
                            data: {
                                'id': id,
                                'type': 'delete' + tablename,
                                'table': tablename,
                            },
                            success: function (response) {


                            }
                        });

                        //console.log(tr);

                        var table = $("#table" + tablename).DataTable();
                        //$(this).parents("td").parents("tr").find(".row-"+tablename+"-isDeleted").html('-1');
                        table.row($(this).parents('tr')).remove().draw();

                    }

                    Swal.fire(
                            'Deleted!',
                            'Votre produit a ete supprime.',
                            'success'
                            )
                });
            }
        })





    });

    $(document).on("click", ".add", function () {





        var _textfield1;
        var fd = new FormData();
        for (i = 0; i < variable.length; i++) {

            if (variable[i] === "Image") {

                fd.append('file', $('#' + variable[i] + '-' + tablename)[0].files[0]);


            } else {
                _textfield1 = $("#" + variable[i] + "-" + tablename).val();
                //alert(_textfield1);
                fd.append(variable[i], _textfield1);


            }


        }

        fd.append('type', 'Add' + tablename);
        fd.append('table', tablename);

        $.ajax({
            url: '/IMTRADE/Manager',
            type: 'POST',
            enctype: "multipart/form-data",
            data: fd,
            processData: false,
            contentType: false,
            success: function (response) {

                if (response === "suc") {

                    var t1 = "GetLastId" + tablename;



                    $.ajax({
                        url: "/IMTRADE/Manager",
                        type: "Post",
                        data: {'type': t1, 'table': tablename},

                        dataType: "json",
                        success: function (response) {

                            var t = response;
                            var table = $("#table" + tablename).DataTable();
                            var index = table.column(0).data().length + 1;




                            var html1 = '<tr class="ligne" id="ligne-' + index + '"> <td id="selectone' + tablename + '"><label class="toggle"><input class="toggle__input" type="checkbox"><span class="toggle__label"></span></label></td><td class="btndraw text-center fixed-column row-' + tablename + '-manage justify-content-center" id="' + t + '"> <div class="btn-group"> <button type="button" class="btn btn-outline-info waves-effect waves-light dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"><i class="fas fa-cogs"></i><span class="caret"></span> </button><div class="dropdown-menu"> <a class="dropdown-item text-info" id="manage' + tablename + '" >VOIR</a> <a class="dropdown-item text-info" id="manage">ÉDITER</a><a class="dropdown-item text-info" id="manage">EFFACER</a>  </div> </div></td><td class="text-left row-' + tablename + '-N°">' + index + '</td>';

                            for (i = 0; i < variableTable.length; i++) {
                                if (variableTable[i] === "Quantité") {

                                    html1 += '<td class="text-left row-' + tablename + '-' + variableTable[i] + '" id="' + index + '">0.0</td>';
                                } else {

                                    _textfield1 = $("#" + variableTable[i] + "-" + tablename).val();

                                    html1 += '<td class="text-left row-' + tablename + '-' + variableTable[i] + '" id="' + index + '">' + _textfield1 + '</td>';
                                }
                            }


                            for (i = 0; i < variableTableAutre.length; i++) {
                                _textfield1 = $("#" + variableTableAutre[i] + "-" + tablename).val();
                                html1 += '<input type="hidden" id="row-' + tablename + '-' + variableTableAutre[i] + '" value="' + _textfield1 + '">';
                            }
                            html1 += '</tr>';

                            //var html='<tr><td> <span class="custom-checkbox"> <input type="checkbox"name="options[]" class="mdl-checkbox" value="1"> <label > </label> </span> </td> <td >'+_textfield1+'</td>  <td >'+_textfield2+'</td> <td >'+_textfield5+'</td> <td >'+_textfield6+'</td> <td >'+_textfield7+'</td>  <td><a href="#" class="view" title="View" data-toggle="tooltip"><i class="material-icons">&#xE417;</i></a> <a href="#" class="edit" title="Edit" data-toggle="tooltip"><i class="material-icons">&#xE254;</i></a><a href="#" class="delete" title="Delete" data-toggle="tooltip"><i class="material-icons">&#xE872;</i></a> </td> </tr>';
                            // $("#table"+tablename+" "+"tbody").append(html1);

                            var dataTable = $("#table" + tablename).dataTable().api();
                            tr = document.createElement("tr");
                            tr.innerHTML = html1;
                            dataTable.row.add(tr);
                            dataTable.draw();

                            for (i = 0; i < variable.length; i++) {


                                $('#collapseadd' + tablename).find('#' + variable[i] + '-' + tablename).val('');

                            }


                        }
                    });

                    Swal.fire(
                            'bien!',
                            'Ajoute Un nouveaux Produit!',
                            'success'
                            )




                } else {
                    Swal.fire({
                        icon: 'error',
                        title: 'Oops...',
                        text: response,

                    })
                }
            }
        });




    });


    $(document).on("click", ".edit" + tablename, function () {



        var return_first;
        function callback(response) {
            return_first = response;

        }
        var fd = new FormData();
        var v1;
        for (i = 0; i < variable.length - 1; i++) {
            v1 = $('#edit' + tablename).find('#' + variable[i] + '-' + tablename).val();

            fd.append(variable[i], v1);

        }

        fd.append('type', 'edit' + tablename);
        var id = $('#edit' + tablename).find('.id-' + tablename).val();


        fd.append('id', id);
        fd.append('table', tablename);
        $.ajax({
            url: '/IMTRADE/Manager',
            type: 'POST',
            enctype: "multipart/form-data",
            data: fd,

            processData: false,
            contentType: false,
            success: function (response) {
                if (response == "suc") {

                    callback(response);
                    var newvar;
                    var line = $('#edit' + tablename).find('.line-' + tablename).val();

                    for (i = 0; i < variableEdit.length; i++) {


                        newvar = $('#edit' + tablename).find('#' + variableEdit[i] + '-' + tablename).val();


                        $('#' + line).find(".row-" + tablename + "-" + variableEdit[i]).text(newvar);
                    }

                    for (i = 0; i < variableTableAutre.length; i++) {
                        newvar = $('#edit' + tablename).find('#' + variableTableAutre[i] + '-' + tablename).val();


                        $('#' + line).find("#row-" + tablename + "-" + variableTableAutre[i]).val(newvar);



                    }



                    Swal.fire(
                            'bien!',
                            'Votre produit a ete mis a jour!',
                            'success'
                            )


                } else {
                    Swal.fire({
                        icon: 'error',
                        title: 'Oops...',
                        text: response,

                    })
                }
            }
        });




    });






    $('#filtrage-' + tablename).change(function ()
    {

        var table = $("#table" + tablename).DataTable();
        checkbox = $('table tbody input[type="checkbox"]');

        table.clear().draw();















    <%List<Produit> listProduit; %>

        var index;
        var html1;
        if ($(this).val() === "All") {
            index = 0;
    <%  listProduit = ModelBean.GetContentTable("Produit", "where isDeleted=" + 0);


    %>




    <%  for (int idx = 0; idx < listProduit.size(); idx++) {
                 Objet obj = (Objet) ModelBean.GetContentTable("Objet", "where id_objet=" + listProduit.get(idx).getIdObjet()).get(0);
                 Structure structure = (Structure) ModelBean.GetContentTable("Structure", "where id_structure=" + obj.getIdStructure()).get(0);

    %>



            index++;
            ;


            var variableTable = ["Material", "Marque", "Modele", "Quantité", "Prix-unitaire", "Structure"];
            html1 = '<tr class="ligne" id="ligne-' + index + '"> <td id="selectone' + tablename + '"><label class="toggle"><input class="toggle__input" type="checkbox"><span class="toggle__label"></span></label></td><td class="btndraw text-center fixed-column row-' + tablename + '-manage justify-content-center" id="<%=listProduit.get(idx).getIdProduit()%>"> <div class="btn-group"> <button type="button" class="btn btn-outline-info waves-effect waves-light dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"><i class="fas fa-cogs"></i><span class="caret"></span> </button><div class="dropdown-menu"> <a class="dropdown-item text-info" id="manage' + tablename + '" >VOIR</a> <a class="dropdown-item text-info" id="manage">ÉDITER</a><a class="dropdown-item text-info" id="manage">EFFACER</a>  </div> </div></td><td class="text-left row-' + tablename + '-N°">' + index + '</td>';

            for (i = 0; i < variableTable.length; i++) {
                if (variableTable[i] === "Quantité") {

                    html1 += '<td class="text-left row-' + tablename + '-' + variableTable[i] + '" id="' + index + '"><%=listProduit.get(idx).getQuantite()%></td>';
                }
                if (variableTable[i] === "Prix-unitaire") {

                    html1 += '<td class="text-left row-' + tablename + '-' + variableTable[i] + '" id="' + index + '"><%=listProduit.get(idx).getPrix()%></td>';
                }
                if (variableTable[i] === "Modele") {

                    html1 += '<td class="text-left row-' + tablename + '-' + variableTable[i] + '" id="' + index + '"><%=listProduit.get(idx).getModele()%></td>';
                }
                if (variableTable[i] === "Marque") {

                    html1 += '<td class="text-left row-' + tablename + '-' + variableTable[i] + '" id="' + index + '"><%=listProduit.get(idx).getMarque()%></td>';
                }
                if (variableTable[i] === "Material") {

                    html1 += '<td class="text-left row-' + tablename + '-' + variableTable[i] + '" id="' + index + '"><%=listProduit.get(idx).getNomProduit()%></td>';
                }
                if (variableTable[i] === "Structure") {

                    html1 += '<td class="text-left row-' + tablename + '-' + variableTable[i] + '" id="' + index + '"><%=structure.getNomStructure()%></td>';
                }



            }


            for (i = 0; i < variableTableAutre.length; i++) {

                if (variableTableAutre[i] === "Designation") {
                    html1 += '<input type="hidden" id="row-' + tablename + '-' + variableTableAutre[i] + '" value="<%=listProduit.get(idx).getDesignation()%>">';

                }

                if (variableTableAutre[i] === "Matricule") {
                    html1 += '<input type="hidden" id="row-' + tablename + '-' + variableTableAutre[i] + '" value="<%=listProduit.get(idx).getMatricule()%>">';

                }
                if (variableTableAutre[i] === "Type") {
                    html1 += '<input type="hidden" id="row-' + tablename + '-' + variableTableAutre[i] + '" value="<%=listProduit.get(idx).getTypeProduit()%>">';

                }
            }
            html1 += '</tr>';

            //var html='<tr><td> <span class="custom-checkbox"> <input type="checkbox"name="options[]" class="mdl-checkbox" value="1"> <label > </label> </span> </td> <td >'+_textfield1+'</td>  <td >'+_textfield2+'</td> <td >'+_textfield5+'</td> <td >'+_textfield6+'</td> <td >'+_textfield7+'</td>  <td><a href="#" class="view" title="View" data-toggle="tooltip"><i class="material-icons">&#xE417;</i></a> <a href="#" class="edit" title="Edit" data-toggle="tooltip"><i class="material-icons">&#xE254;</i></a><a href="#" class="delete" title="Delete" data-toggle="tooltip"><i class="material-icons">&#xE872;</i></a> </td> </tr>';
            // $("#table"+tablename+" "+"tbody").append(html1);

            var dataTable = $("#table" + tablename).dataTable().api();
            tr = document.createElement("tr");
            tr.innerHTML = html1;
            dataTable.row.add(tr);
            dataTable.draw();
    <%
           }
    %>
        }
        if ($(this).val() === "Important") {
            index = 0;
    <%  listProduit = ModelBean.GetContentTable("Produit", "where isDeleted=" + 0);

           Collections.sort(listProduit, new Comparator<Produit>() {
               @Override
               public int compare(Produit u1, Produit u2) {

                   return u1.getUtilise() > u2.getUtilise() ? 1 : u1.getUtilise() < u2.getUtilise() ? -1 : 0;
               }

           });


    %>




    <%  for (int idx = listProduit.size() - 1; idx >= 0; idx--) {
                 Objet obj = (Objet) ModelBean.GetContentTable("Objet", "where id_objet=" + listProduit.get(idx).getIdObjet()).get(0);
                 Structure structure = (Structure) ModelBean.GetContentTable("Structure", "where id_structure=" + obj.getIdStructure()).get(0);

    %>



            index++;


            var variableTable = ["Material", "Marque", "Modele", "Quantité", "Prix-unitaire", "Structure"];
            html1 = '<tr class="ligne" id="ligne-' + index + '"> <td id="selectone' + tablename + '"><label class="toggle"><input class="toggle__input" type="checkbox"><span class="toggle__label"></span></label></td><td class="btndraw text-center fixed-column row-' + tablename + '-manage justify-content-center" id="<%=listProduit.get(idx).getIdProduit()%>"> <div class="btn-group"> <button type="button" class="btn btn-outline-info waves-effect waves-light dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"><i class="fas fa-cogs"></i><span class="caret"></span> </button><div class="dropdown-menu"> <a class="dropdown-item text-info" id="manage' + tablename + '" >VOIR</a> <a class="dropdown-item text-info" id="manage">ÉDITER</a><a class="dropdown-item text-info" id="manage">EFFACER</a>  </div> </div></td><td class="text-left row-' + tablename + '-N°">' + index + '</td>';

            for (i = 0; i < variableTable.length; i++) {
                if (variableTable[i] === "Quantité") {

                    html1 += '<td class="text-left row-' + tablename + '-' + variableTable[i] + '" id="' + index + '"><%=listProduit.get(idx).getQuantite()%></td>';
                }
                if (variableTable[i] === "Prix-unitaire") {

                    html1 += '<td class="text-left row-' + tablename + '-' + variableTable[i] + '" id="' + index + '"><%=listProduit.get(idx).getPrix()%></td>';
                }
                if (variableTable[i] === "Modele") {

                    html1 += '<td class="text-left row-' + tablename + '-' + variableTable[i] + '" id="' + index + '"><%=listProduit.get(idx).getModele()%></td>';
                }
                if (variableTable[i] === "Marque") {

                    html1 += '<td class="text-left row-' + tablename + '-' + variableTable[i] + '" id="' + index + '"><%=listProduit.get(idx).getMarque()%></td>';
                }
                if (variableTable[i] === "Material") {

                    html1 += '<td class="text-left row-' + tablename + '-' + variableTable[i] + '" id="' + index + '"><%=listProduit.get(idx).getNomProduit()%></td>';
                }
                if (variableTable[i] === "Structure") {

                    html1 += '<td class="text-left row-' + tablename + '-' + variableTable[i] + '" id="' + index + '"><%=structure.getNomStructure()%></td>';
                }



            }


            for (i = 0; i < variableTableAutre.length; i++) {

                if (variableTableAutre[i] === "Designation") {
                    html1 += '<input type="hidden" id="row-' + tablename + '-' + variableTableAutre[i] + '" value="<%=listProduit.get(idx).getDesignation()%>">';

                }

                if (variableTableAutre[i] === "Matricule") {
                    html1 += '<input type="hidden" id="row-' + tablename + '-' + variableTableAutre[i] + '" value="<%=listProduit.get(idx).getMatricule()%>">';

                }
                if (variableTableAutre[i] === "Type") {
                    html1 += '<input type="hidden" id="row-' + tablename + '-' + variableTableAutre[i] + '" value="<%=listProduit.get(idx).getTypeProduit()%>">';

                }
            }
            html1 += '</tr>';

            //var html='<tr><td> <span class="custom-checkbox"> <input type="checkbox"name="options[]" class="mdl-checkbox" value="1"> <label > </label> </span> </td> <td >'+_textfield1+'</td>  <td >'+_textfield2+'</td> <td >'+_textfield5+'</td> <td >'+_textfield6+'</td> <td >'+_textfield7+'</td>  <td><a href="#" class="view" title="View" data-toggle="tooltip"><i class="material-icons">&#xE417;</i></a> <a href="#" class="edit" title="Edit" data-toggle="tooltip"><i class="material-icons">&#xE254;</i></a><a href="#" class="delete" title="Delete" data-toggle="tooltip"><i class="material-icons">&#xE872;</i></a> </td> </tr>';
            // $("#table"+tablename+" "+"tbody").append(html1);

            var dataTable = $("#table" + tablename).dataTable().api();
            tr = document.createElement("tr");
            tr.innerHTML = html1;
            dataTable.row.add(tr);
            dataTable.draw();
    <%
           }
    %>
        }


    });


</script>



